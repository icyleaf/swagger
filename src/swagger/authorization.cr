module Swagger
  # Define a authentication
  #
  # Avaibled authentication in `Type`
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

    # Access without any authorization.
    def self.none(description : String? = nil)
      new(Type::None, description)
    end

    # Access with basic auth.
    def self.basic(description : String? = nil)
      new(Type::Basic, description)
    end

    # Access with jwt auth.
    def self.jwt(description : String? = nil)
      bearer(format: "JWT", description: description)
    end

    # Access with bearer auth.
    def self.bearer(*, format : String? = nil, description : String? = nil)
      new(Type::Bearer, description, bearer_format: format)
    end

    # Access with api key auth.
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

    def type : Type
      @name
    end

    # Transform type to String typed and downcase of value
    def name : String
      @name.to_s.downcase
    end

    # Transform name to unique key name
    #
    # ```
    # Swagger::Authorization.basic.key # => "basic_auth"
    # Swagger::Authorization.bearer.key # => "bearer_auth"
    # Swagger::Authorization.bearer(format: "custom").key # => "custom_auth"
    # Swagger::Authorization.jwt.key.˙ # => "jwt_auth"
    # Swagger::Authorization.api_key.key.˙ # => "api_key_auth"
    # ```
    def key
      Array(String).new.tap do |obj|
        if type == Authorization::Type::Bearer && (format = bearer_format)
          obj << format.downcase
        else
          obj << name
        end
        obj << "auth"
      end.join("_")
    end
  end
end
