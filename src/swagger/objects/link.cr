module Swagger::Object
  # Link Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#linkObject
  struct Link
    include JSON::Serializable

    @[JSON::Field(key: "operationRef")]
    getter operation_ref : String? = nil

    @[JSON::Field(key: "operationId")]
    getter operation_id : String? = nil

    getter parameters : Hash(String, String)? = nil

    @[JSON::Field(key: "requestBody")]
    getter request_body : String? = nil
    getter description : String? = nil
    getter server : Server? = nil

    @[JSON::Field(key: "$ref")]
    getter ref : String? = nil

    def initialize(@operation_ref : String? = nil, @operation_id : String? = nil,
                  @parameters : Hash(String, String)? = nil, @request_body : String? = nil,
                  @description : String? = nil, @server : Server? = nil, @ref : String? = nil)
    end
  end
end
