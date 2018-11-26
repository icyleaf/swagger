module Swagger::Objects
  # OAuth2 Flow Object
  struct OAuth2Flow
    include JSON::Serializable

    GRANT_TYPES = %w(authorizationCode implicit password clientCredentials)

    @[JSON::Field(key: "authorizationUrl")]
    getter authorization_url : String? = nil

    @[JSON::Field(key: "tokenUrl")]
    getter token_url : String? = nil

    @[JSON::Field(key: "refreshUrl")]
    getter refresh_url : String? = nil
    getter scopes : Hash(String, String)? = nil

    def initialize(@authorization_url : String? = nil, @token_url : String? = nil,
                   @refresh_url : String? = nil, @scopes : Hash(String, String)? = nil)
    end
  end
end
