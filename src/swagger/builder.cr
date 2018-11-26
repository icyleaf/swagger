module Swagger
  class Builder
    @controllers = Array(Controller).new
    @servers = Array(Server).new
    @objects = Array(Structure).new

    def initialize(@title : String, @version : String, @description : String? = nil,
                   @terms_url : String? = nil, @license : Object::Info::License? = nil, @contact : Object::Info::Contact? = nil,
                   @authorizations : Array(Authorization)? = nil)
    end

    def add(controller name : String, description : String, actions : Array(Action))
      add(Controller.new(name, description, actions))
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

    def add(object : Structure)
      @objects << object
    end

    def <<(object : Structure)
      add(object)
    end

    def built
      security_schemes = build_security_schemes
      security = build_security(security_schemes)
      components = build_components(security_schemes)
      paths = build_paths(security)

      Document.new(
        info: build_info,
        servers: build_servers,
        tags: build_tags,
        paths: paths,
        components: components,
      )
    end

    private def build_info
      Object::Info.new(@title, @version, @description, @terms_url, @license, @contact)
    end

    private def build_servers
      @servers.each_with_object(Array(Object::Server).new) do |server, obj|
        variables = if vars = server.variables
          vars.each_with_object(Hash(String, Object::Server::Variable).new) do |var, obj|
            obj[var.name] = Object::Server::Variable.new(var.default_value, var.enum_values, var.description)
          end
        end

        obj << Object::Server.new(server.url, server.description, variables)
      end
    end

    private def build_tags
      @controllers.each_with_object(Array(Object::Tag).new) do |controller, obj|
        obj << Object::Tag.new(controller.name, controller.description, controller.external_docs)
      end
    end

    private def build_paths(security)
      @controllers.each_with_object(Hash(String, Object::PathItem).new) do |controller, obj|
        controller.actions.each do |action|
          operation = Object::Operation.from(action, controller.name, security)

          unless path = obj[action.route]?
            path = Object::PathItem.new
          end

          path.add(action.method, operation)
          obj[action.route] = path
        end
      end
    end

    private def build_components(security_schemes)
      Object::Components.new(security_schemes: security_schemes)
    end

    def build_security(security_schemes)
      return unless security_schemes
      security_schemes.keys.each_with_object(Hash(String, Array(String)).new) do |name, obj|
        obj[name] = Array(String).new
      end
    end

    def build_security_schemes
      return unless authorizations = @authorizations
      authorizations.each_with_object(Hash(String, Object::SecurityScheme).new) do |auth, obj|
        scheme = case auth.type
                  when Authorization::Type::Basic
                    Object::SecurityScheme.new(
                      "http",
                      auth.description,
                      parameter_location: "header",
                      scheme: "basic"
                    )
                  when Authorization::Type::Bearer
                    Object::SecurityScheme.new(
                      "http",
                      auth.description,
                      parameter_location: "header",
                      scheme: "bearer",
                      bearer_format: auth.bearer_format
                    )
                  when Authorization::Type::APIKey
                    Object::SecurityScheme.new(
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
