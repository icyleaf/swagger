require "./action"
require "./objects/external_docs"

module Swagger
  # Define a controller
  #
  # ```
  # Swagger::Controller.new("Users", "User APIs", [
  #   Swagger::Action.new("get", "/users"),
  #   Swagger::Action.new("get", "/users/{id}"),
  #   Swagger::Action.new("post", "/users"),
  #   Swagger::Action.new("put", "/users/{id}"),
  #   Swagger::Action.new("delete", "/users/{id}"),
  # ]
  # ```
  struct Controller
    property name
    property description
    property actions
    property external_docs

    def initialize(@name : String, @description : String, @actions = [] of Swagger::Action,
                   @external_docs : Objects::ExternalDocs? = nil)
    end
  end
end
