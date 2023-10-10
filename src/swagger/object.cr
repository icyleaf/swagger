module Swagger
  # Object is define a schema struct
  #
  # > This is no relationship with `Objects` structs.
  #
  # ```
  # Swagger::Object.new("User", "object", [
  #   Swagger::Property.new("id", "integer", "int32", example: 1),
  #   Swagger::Property.new("nickname", example: "icyleaf wang"),
  #   Swagger::Property.new("username", example: "icyleaf"),
  #   Swagger::Property.new("email", example: "icyleaf.cn@gmail.com"),
  #   Swagger::Property.new("bio", "Personal bio"),
  # ])
  # ```
  class Object
    property name
    property type
    property properties
    property items

    def initialize(@name : String, @type : String, @properties : Array(Property)? = nil,
                   @items : (self | String)? = nil)
    end

    def self.create_from_instance(reflecting instance : T, custom_name : String? = nil, refs : Hash(String, (String | self))? = nil) forall T
      {% begin %}
        instance_name = custom_name ? custom_name.as(String) : compliant_type_name(instance.class)
        properties = [] of Property
        {% for ivar in T.instance.instance_vars %}
          {{ iname = ivar.name.stringify }}
          {{ irequired = !ivar.type.union? }}
          value = {% if T.class? || T.struct? %} instance.{{ ivar.name }} {% else %} {{ ivar.default_value.stringify }} {% end %}
          {% if ivar.type.union? %}
            {{ type_ivar = ivar.type.union_types.find { |var| var != Nil } }}
          {% else %}
            {{ type_ivar = ivar.type }}
          {% end %}
          swagger_data_type = Utils::SwaggerDataType.create_from_class({{ type_ivar }})
          properties << Property.new(
            {{ iname }},
            swagger_data_type.type,
            format: swagger_data_type.format,
            {% if type_ivar <= String || type_ivar <= Int32 ||
                    type_ivar <= Int64 || type_ivar <= Float64 ||
                    type_ivar <= Bool %}
              example: value,
            {% elsif type_ivar <= UInt16 || type_ivar <= UInt8 ||
                       type_ivar <= Int16 || type_ivar <= Int8 %}
              example: !value.nil? ? value.to_i32 : nil,
            {% elsif type_ivar <= UInt32 %}
              example: !value.nil? ? value.to_i64 : nil,
            {% elsif type_ivar <= Float32 %}
              example: !value.nil? ? value.to_f64 : nil,
            {% elsif type_ivar <= Enum %}
              example: !value.nil? ? value.to_s : nil,
              enum_values: {{ type_ivar }}.names,
            {% elsif type_ivar <= Array %}
              items: ({{ type_ivar.type_vars }}.first? ?
                ( instance_name == {{ type_ivar.type_vars }}.first.name ?
                  instance_name
                :
                  resolve_ref({{ type_ivar.type_vars }}.first, instance_name, refs)
                )
                : nil
              ),
            {% else %}
            ref: (instance_name == {{ type_ivar }}.name ?
                instance_name : resolve_ref({{ type_ivar }}, instance_name, refs)
              ),
            {% end %}
            required: {{ irequired }},
          )
        {% end %}

        self.new(instance_name, "object", properties)
      {% end %}
    end

    class RefResolutionException < Exception
    end

    private def self.resolve_ref(type : T.class, caller_type_name : String, refs : Hash(String, (String | self))? = nil) : String forall T
      swagger_data_type = Utils::SwaggerDataType.create_from_class(type)
      if swagger_data_type.type != "array" && swagger_data_type.type != "object"
        return swagger_data_type.type
      end

      type_name = compliant_type_name(type)
      # Self references
      if caller_type_name == type_name
        return type_name
      end

      if refs.nil?
        raise RefResolutionException.new("No refs provided !")
      end

      current_ref = refs[type_name]?
      if current_ref.nil?
        raise RefResolutionException.new("Ref for #{type} not found (Searched for followed name : #{type_name})")
      end

      return current_ref.is_a?(String) ? current_ref : current_ref.name
    end

    def self.compliant_type_name(type : T.class) : String forall T
      type.name.gsub("::") { "" }.camelcase(
        options: Unicode::CaseOptions::ASCII,
        lower: true
      )
    end
  end
end
