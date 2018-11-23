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
  end
end
