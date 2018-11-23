module Swagger
  struct Authorization
    # Authorization types
    #
    # See https://swagger.io/docs/specification/authentication/
    enum Type
      None
      Basic
      Bearer
      APIKey
      # OAuth2
    end

    def self.none(description : String? = nil)
      new(Type::None, description)
    end

    def self.basic(description : String? = nil)
      new(Type::Basic, description)
    end

    def self.jwt(description : String? = nil)
      bearer(format: "JWT", description: description)
    end

    def self.bearer(*, format : String? = nil, description : String? = nil)
      new(Type::Bearer, description, bearer_format: format)
    end

    def self.api_key(*, name : String, location = "header", description : String? = nil)
      new(Type::APIKey, description, api_key_name: name, parameter_location: location)
    end

    # def self.oauth2(description : String? = nil)
    #   new(OAuth2, description)
    # end

    def self.new(name : String, description : String? = nil, api_key_name : String? = nil,
                 bearer_format : String? = nil, parameter_location : String? = nil)
      new(Type.parse(name), description, api_key_name, bearer_format, parameter_location)
    end

    getter name
    property description
    property api_key_name
    property bearer_format
    property parameter_location

    def initialize(@name : Type, @description : String? = nil, @api_key_name : String? = nil,
                   @bearer_format : String? = nil, @parameter_location : String? = nil)
    end

    def name
      @name.to_s.downcase
    end

    def type
      @name
    end
  end
end
