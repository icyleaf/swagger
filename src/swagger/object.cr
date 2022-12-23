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

    def self.create_from_instance(reflecting instance : T, custom_name : String? = nil, refs : Hash(Class, (String | self))? = nil) forall T
      {% begin %}
        properties = [] of Property
        {% for ivar in T.instance.instance_vars %}
          {{ iname = ivar.name.stringify }}
          swagger_data_type = Utils::SwaggerDataType.create_from_class({{ ivar.type }})
          {{ irequired = !ivar.type.union? }}
          value = {% if T.class? || T.struct? %} instance.{{ ivar.name }} {% else %} {{ ivar.default_value.stringify }} {% end %}
          {% if ivar.type.union? %}
            {{ type_ivar = ivar.type.union_types.find { |var| var != Nil } }}
          {% else %}
            {{ type_ivar = ivar.type }}
          {% end %}
          properties << Property.new(
            {{ iname }},
            swagger_data_type.type,
            format: swagger_data_type.format,
            {% if type_ivar <= String || type_ivar <= Int32 ||
                    type_ivar <= Int64 || type_ivar <= Float64 ||
                    type_ivar <= Bool %}
              example: value,
            {% elsif type_ivar <= Enum %}
              example: value.to_s,
              enum_values: {{ type_ivar }}.names,
            {% else %}
              ref: resolve_ref({{ type_ivar }}, refs),
            {% end %}
            required: {{ irequired }},
          )
        {% end %}

        self.new(custom_name ? custom_name.as(String) : instance.class.name, "object", properties)
      {% end %}
    end

    class RefResolutionException < Exception
    end

    private def self.resolve_ref(type : T.class, refs : Hash(Class, (String | self))? = nil) : String forall T
      if refs.nil?
        raise RefResolutionException.new("No refs provided !")
      end

      current_ref = refs[type]?
      if current_ref.nil?
        raise RefResolutionException.new("Ref for #{type} not found")
      end

      return current_ref.is_a?(String) ? current_ref : current_ref.name
    end
  end
end
