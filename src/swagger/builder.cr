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
      Document.new(
        info: info,
        paths: paths,
        servers: servers,
        tags: tags,
        components: components
      )
    end

    private def info
      Object::Info.new(@title, @version, @description, @terms_url, @license, @contact)
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

    private def components
      @objects.each_with_object(Hash(String, Object::Schema).new) do |object, obj|

      end
    end
  end
end
