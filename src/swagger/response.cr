require "./objects/media_type"

module Swagger
  struct Response
    def self.new(code : String, description : String, reference name : String, content_type : String? = nil)
      schema = Schema.use_reference(name)
      new(code, description, schema, content_type)
    end

    def self.new(code : String, description : String, schema : Schema, content_type : String? = nil)
      new(code, description, MediaType.new(schema), content_type)
    end

    property code
    property description
    property media_type
    property content_type : String

    def initialize(@code : String, @description : String, @media_type : Objects::MediaType? = nil, content_type : String? = nil)
      @content_type = content_type || "application/json"
    end

    def content
      return unless media_type = @media_type

      {
        @content_type => media_type,
      }
    end
  end
end
