module Swagger::Objects
  # SecurityScheme Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#componentsSecuritySchemes
  struct SecurityScheme
    include JSON::Serializable

    getter type : String? = nil
    getter description : String? = nil
    getter name : String? = nil

    @[JSON::Field(key: "in")]
    getter parameter_location : String? = nil

    getter scheme : String? = nil

    @[JSON::Field(key: "bearerFormat")]
    getter bearer_format : String? = nil

    # getter flows : OpenAPIOAuthFlows? = nil

    @[JSON::Field(key: "openIdConnectUrl")]
    getter open_id_connect_url : String? = nil

    @[JSON::Field(key: "$ref")]
    getter ref : String? = nil

    def initialize(@type : String? = nil, @description : String? = nil, @name : String? = nil,
                   @parameter_location : String? = nil, @scheme : String? = nil,
                   @bearer_format : String? = nil, @open_id_connect_url : String? = nil,
                   @ref : String? = nil)
    end
  end
end
