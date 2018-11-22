module Swagger::Object
  struct Property
    include JSON::Serializable

    getter type : String
    getter examples : String? = nil

    def initialize(@type : String, @examples : String? = nil)
    end
  end
end
