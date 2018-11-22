module Swagger::Object
  struct Parameter
    include JSON::Serializable

    getter name : String

    @[JSON::Field(key: "in")]
    getter parameter_location : String

    getter description : String? = nil
    getter required : Bool = false

    @[JSON::Field(key: "allowEmptyValue")]
    getter allow_empty_value : Bool = false

    getter deprecated : Bool = false

    @[JSON::Field(key: "$ref")]
    getter ref : String? = nil

    def initialize(@name : String, @parameter_location : String, @description : String? = nil)
      # If the parameter location is "path", this property is REQUIRED and its value MUST be true.
      # Otherwise, the property MAY be included and its default value is false.
      @required = true if @parameter_location == "path"
    end
  end
end

alias Swagger::Parameter = Swagger::Object::Parameter
