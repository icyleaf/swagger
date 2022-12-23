module Utils
  struct SwaggerDataType
    property type : String
    property format : String?

    def initialize(@type : String, @format : String?)
    end

    def self.create_from_class(type : T.class) forall T
      {% begin %}
        {% if T.union? %}
          return self.create_from_class({{ T.union_types.find { |var| var != Nil } }})
        {% else %}
          # Cf https://swagger.io/specification/#data-types
          {% if T <= String %}
            swagger_type = "string"
            swagger_format = nil
          {% elsif T <= Int %}
            swagger_type = "integer"
            {% if T <= Int32 %}
              swagger_format = "int32"
            {% elsif T <= Int64 %}
              swagger_format = "int64"
            {% else %}
              swagger_format = nil
            {% end %}
          {% elsif T <= Number %}
            swagger_type = "number"
            {% if T <= Float32 %}
              swagger_format = "float"
            {% elsif T <= Float64 %}
              swagger_format = "double"
            {% else %}
              swagger_format = nil
            {% end %}
          {% elsif T <= Bool %}
            swagger_type = "boolean"
            swagger_format = nil
          {% else %}
            swagger_type = "object"
            swagger_format = nil
          {% end %}
          return self.new(swagger_type, swagger_format)
        {% end %}
      {% end %}
    end
  end
end
