module Swagger::Objects
  # Components Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#componentsObject
  struct Components
    include JSON::Serializable

    getter schemas : Hash(String, Schema)? = nil
    getter responses : Hash(String, Response)? = nil
    getter parameters : Hash(String, Parameter)? = nil
    getter examples : Hash(String, Example)? = nil

    @[JSON::Field(key: "requestBodies")]
    getter request_bodies : Hash(String, RequestBody)? = nil

    getter headers : Hash(String, Header)? = nil

    @[JSON::Field(key: "securitySchemes")]
    getter security_schemes : Hash(String, SecurityScheme)? = nil

    getter links : Hash(String, Link)? = nil
    getter callbacks : Hash(String, Hash(String, PathItem))? = nil

    def initialize(@schemas : Hash(String, Schema)? = nil, @responses : Hash(String, Response)? = nil,
                   @parameters : Hash(String, Parameter)? = nil, @examples : Hash(String, Example)? = nil,
                   @request_bodies : Hash(String, RequestBody)? = nil, @headers : Hash(String, Header)? = nil,
                   @security_schemes : Hash(String, SecurityScheme)? = nil, @links : Hash(String, Link)? = nil,
                   @callbacks : Hash(String, Hash(String, PathItem))? = nil)
    end
  end
end
