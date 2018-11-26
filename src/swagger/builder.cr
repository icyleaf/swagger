require "./objects/*"

module Swagger
  class Builder
    property info
    property controllers = Array(Controller).new
    property servers = Array(Server).new
    property objects = Array(Object).new

    def self.new(title : String, version : String, description : String? = nil,
                 terms_url : String? = nil, license : License? = nil, contact : Contact? = nil,
                 authorizations : Array(Authorization)? = nil)
      new(Info.new(title, version, description, terms_url, license, contact), authorizations)
    end

    def initialize(@info : Info, @authorizations : Array(Authorization)? = nil)
    end

    def add(*, controller name : String, description : String, actions : Array(Action), external_docs : Objects::ExternalDocs? = nil)
      add(Controller.new(name, description, actions, external_docs))
    end

    def add(*, server name : String, description : String? = nil, variables : Array(Variable)? = nil)
      add(Server.new(name, description, variables))
    end

    def add(controller : Controller)
      @controllers << controller
    end

    def <<(controller : Controller)
      add(controller)
    end

    def add(server : Server)
      @servers << server
    end

    def <<(server : Server)
      add(server)
    end

    def add(object : Object)
      @objects << object
    end

    def <<(object : Object)
      add(object)
    end

    def built
      security_schemes = build_security_schemes
      security = build_security(security_schemes)
      components = build_components(security_schemes)
      paths = build_paths(security)

      Document.new(
        info: @info,
        servers: build_servers,
        tags: build_tags,
        paths: paths,
        components: components,
      )
    end

    private def build_servers
      @servers.each_with_object(Array(Objects::Server).new) do |server, obj|
        variables = if vars = server.variables
          vars.each_with_object(Hash(String, Objects::Server::Variable).new) do |var, obj|
            obj[var.name] = Objects::Server::Variable.new(var.default_value, var.enum_values, var.description)
          end
        end

        obj << Objects::Server.new(server.url, server.description, variables)
      end
    end

    private def build_tags
      @controllers.each_with_object(Array(Objects::Tag).new) do |controller, obj|
        obj << Objects::Tag.new(controller.name, controller.description, controller.external_docs)
      end
    end

    private def build_paths(security)
      @controllers.each_with_object(Hash(String, Objects::PathItem).new) do |controller, obj|
        controller.actions.each do |action|
          operation = Objects::Operation.from(action, controller.name, security)

          unless path = obj[action.route]?
            path = Objects::PathItem.new
          end

          path.add(action.method, operation)
          obj[action.route] = path
        end
      end
    end

    private def build_components(security_schemes)
      schemas = if objects = @objects
        schema = objects.each_with_object(Hash(String, Schema).new) do |object, schemas_obj|
          properties = object.properties.each_with_object(Hash(String, Objects::Property).new) do |property, prop_obj|
            prop_obj[property.name] = Objects::Property.new(
              type: property.type,
              description: property.description,
              example: property.example
            )
          end

          schemas_obj[object.name] = Schema.new(type: object.type, properties: properties)
        end
      end

      Objects::Components.new(security_schemes: security_schemes, schemas: schemas)
    end

    def build_security(security_schemes)
      return unless security_schemes
      security_schemes.keys.each_with_object(Hash(String, Array(String)).new) do |name, obj|
        obj[name] = Array(String).new
      end
    end

    def build_security_schemes
      return unless authorizations = @authorizations
      authorizations.each_with_object(Hash(String, Objects::SecurityScheme).new) do |auth, obj|
        scheme = case auth.type
                  when Authorization::Type::Basic
                    Objects::SecurityScheme.new(
                      "http",
                      auth.description,
                      parameter_location: "header",
                      scheme: "basic"
                    )
                  when Authorization::Type::Bearer
                    Objects::SecurityScheme.new(
                      "http",
                      auth.description,
                      parameter_location: "header",
                      scheme: "bearer",
                      bearer_format: auth.bearer_format
                    )
                  when Authorization::Type::APIKey
                    Objects::SecurityScheme.new(
                      "apiKey",
                      auth.description,
                      name: auth.api_key_name,
                      parameter_location: auth.parameter_location,
                      bearer_format: auth.bearer_format
                    )
                  end
        obj[security_name(auth)] = scheme if scheme
      end
    end

    def security_name(authorization)
      Array(String).new.tap do |obj|
        if authorization.type == Authorization::Type::Bearer && (format = authorization.bearer_format)
          obj << format.downcase
        else
          obj << authorization.name
        end
        obj << "auth"
      end.join("_")
    end
  end
end
