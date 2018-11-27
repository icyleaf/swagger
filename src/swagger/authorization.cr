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
      OAuth2
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

    # Access with cookie auth.
    def self.cookie(*, name : String, description : String? = nil)
      new(Type::APIKey, description, api_key_name: name, parameter_location: "cookie")
    end

    # Access with api key auth.
    def self.api_key(*, name : String, location = "header", description : String? = nil)
      new(Type::APIKey, description, api_key_name: name, parameter_location: location)
    end

    def self.oauth2(*, grant_type name : String, authorization_url : String? = nil, token_url : String? = nil,
                    refresh_url : String? = nil, scopes : Hash(String, String)? = nil, description : String? = nil)
      oauth2(flows: [OAuth2Flow.new(name,
        authorization_url: authorization_url,
        token_url: token_url,
        refresh_url: refresh_url,
        scopes: scopes
      )])
    end

    def self.oauth2(*, flows : Array(OAuth2Flow)? = nil, description : String? = nil)
      new(Type::OAuth2, description, oauth2_flows: flows)
    end

    def self.new(name : String, description : String? = nil, api_key_name : String? = nil,
                 bearer_format : String? = nil, parameter_location : String? = nil)
      new(Type.parse(name), description, api_key_name, bearer_format, parameter_location)
    end

    getter name
    property description
    property api_key_name
    property bearer_format
    property parameter_location
    property oauth2_flows

    def initialize(@name : Type, @description : String? = nil, @api_key_name : String? = nil,
                   @bearer_format : String? = nil, @parameter_location : String? = nil,
                   @oauth2_flows : Array(OAuth2Flow)? = nil)
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
    # Swagger::Authorization.basic.key                        # => "basic_auth"
    # Swagger::Authorization.bearer.key                       # => "bearer_auth"
    # Swagger::Authorization.bearer(format: "custom").key     # => "custom_auth"
    # Swagger::Authorization.jwt.key.˙                        # => "jwt_auth"
    # Swagger::Authorization.api_key.key.˙                    # => "api_key_auth"
    # Swagger::Authorization.cookie(name: "JSESSIONID").key.˙ # => "cookie_auth"
    # ```
    def key
      String.build do |io|
        if type == Authorization::Type::Bearer && (format = @bearer_format)
          io << format.downcase
        elsif type == Authorization::Type::APIKey && @parameter_location == "cookie"
          io << "cookie"
        else
          io << name
        end

        io << "_auth"
      end
    end
  end
end
