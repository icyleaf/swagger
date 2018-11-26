module Swagger::Objects
  # Path Item Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#pathItemObject
  struct PathItem
    include JSON::Serializable

    METHODS = %w(get put post delete options head patch trace)

    getter summary : String? = nil
    getter description : String? = nil
    getter get : Objects::Operation?
    getter put : Objects::Operation?
    getter post : Objects::Operation?
    getter delete : Objects::Operation?
    getter options : Objects::Operation?
    getter head : Objects::Operation?
    getter patch : Objects::Operation?
    getter trace : Objects::Operation?

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
