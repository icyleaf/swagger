module Swagger
  class Builder
    @controllers = Array(Controller).new
    @servers = Array(Server).new
    @objects = Array(String).new

    def initialize(@title : String, @version : String, @description : String? = nil,
                   @terms_url : String? = nil, @license : Object::Info::License? = nil, @contact : Object::Info::Contact? = nil,
                   @authorizations : Array(Object::Info::AuthorizationType)? = nil)
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

    def built
      Document.new(
        info: info,
        paths: paths,
        servers: servers,
        tags: tags
      )
    end

    private def info
      Object::Info.new(@title, @version, @description, @terms_url, @license, @contact, @authorizations)
    end

    private def paths
      @controllers.each_with_object(Hash(String, Object::PathItem).new) do |controller, obj|
        controller.actions.each do |action|
          operation = Object::Operation.from(action, controller.name)

          unless path = obj[action.route]?
            path = Object::PathItem.new
          end

          path.add(action.method, operation)
          obj[action.route] = path
        end
      end
    end

    private def servers
      @servers.each_with_object(Array(Object::Server).new) do |server, obj|
        variables = if vars = server.variables
          vars.each_with_object(Hash(String, Object::Server::Variable).new) do |var, obj|
            obj[var.name] = Object::Server::Variable.new(var.default_value, var.enum_values, var.description)
          end
        end

        obj << Object::Server.new(server.url, server.description, variables)
      end
    end

    private def tags
      @controllers.each_with_object(Array(Object::Tag).new) do |controller, obj|
        obj << Object::Tag.new(controller.name, controller.description)
      end
    end
  end
end
