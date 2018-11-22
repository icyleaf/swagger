module Swagger::Object
  struct Response
    include JSON::Serializable

    getter description : String
    getter headers : Hash(String, Header)? = nil
    getter content : Array(MediaType)? = nil
    getter links : Array(Link)? = nil

    @[JSON::Field(key: "$ref")]
    getter ref : String? = nil

    def initialize(@description : String, @headers : Hash(String, Header)? = nil,
                   @content : Array(MediaType)? = nil, links : Array(Link)? = nil, @ref : String? = nil)
    end

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
end
