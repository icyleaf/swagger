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

    def self.create_from_instance(reflecting instance : T, custom_name : String? = nil) forall T
      {% begin %}
        properties = [] of Property
        {% for ivar in T.instance.instance_vars %}
          {{ iname = ivar.name.stringify }}
          swagger_data_type = Utils::SwaggerDataType.create_from_class({{ ivar.type }})
          {{ irequired = !ivar.type.union? }}
          value = {% if T.class? || T.struct? %} instance.{{ ivar.name }} {% else %} {{ ivar.default_value.stringify }} {% end %}
          properties << Property.new(
            {{ iname }},
            swagger_data_type.type,
            format: swagger_data_type.format,
            {% if ivar.type <= String || ivar.type <= Int32 ||
                    ivar.type <= Int64 || ivar.type <= Float64 ||
                    ivar.type <= Bool %}
              example: value,
            {% else %}
              example: value.to_s,
            {% end %}
            required: {{ irequired }}
          )
        {% end %}

        self.new(custom_name ? custom_name.as(String) : instance.class.name, "object", properties)
      {% end %}
    end
  end
end
