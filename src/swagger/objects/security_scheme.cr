module Swagger::Objects
  # SecurityScheme Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#componentsSecuritySchemes
  struct SecurityScheme
    include JSON::Serializable

    def self.new(auth : Authorization)
      scheme = case auth.type
      when Authorization::Type::Basic
        basic(auth.description)
      when Authorization::Type::Bearer
        bearer(auth.description, auth.bearer_format)
      when Authorization::Type::APIKey
        api_key(auth.api_key_name.not_nil!, auth.parameter_location.not_nil!, auth.description)
      end
    end

    def self.basic(description : String? = nil)
      new("http", description, parameter_location: "header", scheme: "basic")
    end

    def self.bearer(description : String? = nil, format : String? = nil)
      new("http", description, parameter_location: "header", scheme: "basic", bearer_format: format)
    end

    def self.api_key(name : String, location : String, description : String? = nil)
      new("apiKey", description, name: name, parameter_location: location)
    end

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
