module Swagger::Object
  # Path Item Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#pathItemObject
  struct PathItem
    include JSON::Serializable

    getter summary : String? = nil
    getter description : String? = nil
    getter get : Object::Operation?
    getter put : Object::Operation?
    getter post : Object::Operation?
    getter delete : Object::Operation?
    getter options : Object::Operation?
    getter head : Object::Operation?
    getter patch : Object::Operation?
    getter trace : Object::Operation?

    @[JSON::Field(key: "$ref")]
    getter ref : String? = nil

    def initialize(@summary : String? = nil, @description : String? = nil, @ref : String? = nil)
    end

    def add(method, operation)
      case method
      when "get"
        @get = operation
      when "put"
        @put = operation
      when "post"
        @post = operation
      when "delete"
        @delete = operation
      when "options"
        @options = operation
      when "head"
        @head = operation
      when "patch"
        @patch = operation
      when "trace"
        @trace = operation
      else
        # TODO: may be throw an exception?
        puts "Not implemented"
      end
    end
  end
end
