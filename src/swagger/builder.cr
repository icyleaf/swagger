require "./objects/*"

module Swagger
  # Swagger Builder
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
                    schemas_obj[object.name.not_nil!] = build_schema(object)
                  end
                end

      Objects::Components.new(security_schemes: security_schemes, schemas: schemas)
    end

    private def build_schema(object : Object) : Objects::Schema
      if object.type == "array"
        if items = object.items
          if items.is_a?(String)
            schema_items = Objects::Schema.use_reference(items)
          else
            schema_items = build_schema(items)
          end

          Objects::Schema.new(type: object.type, items: schema_items)
        else
          raise %(OpenAPI v3 requires "items" to be specified when the type is "array")
        end
      else
        properties = object.properties.try &.each_with_object(Hash(String, Objects::Property).new) do |property, prop_obj|
          prop_obj[property.name] = build_property(property)
        end
        Objects::Schema.new(type: object.type, properties: properties)
      end
    end

    private def build_property(property : Property) : Objects::Property
      if ref = property.ref
        Objects::Property.use_reference(ref)
      elsif property.type == "array"
        if items = property.items
          if items.is_a?(String)
            prop_items = Objects::Schema.use_reference(items)
          else
            prop_items = build_schema(items)
          end

          Objects::Property.new(
            type: property.type,
            description: property.description,
            example: property.example,
            items: prop_items,
          )
        else
          raise %(OpenAPI v3 requires "items" to be specified when the type is "array")
        end
      else
        Objects::Property.new(
          type: property.type,
          description: property.description,
          example: property.example,
        )
      end
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
        if scheme = Objects::SecurityScheme.new(auth)
          obj[auth.key] = scheme
        end
      end
    end
  end
end
