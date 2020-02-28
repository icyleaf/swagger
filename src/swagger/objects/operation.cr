require "json"

require "./parameter"
require "./request_body"
require "./response"
require "./server"

module Swagger::Objects
  # Operation Object
  #
  # See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.3.md#operationObject
  struct Operation
    include JSON::Serializable

    def self.from(action : Action, controller_name : String? = nil, security : Hash(String, Array(String))? = nil)
      new(
        summary: action.summary,
        description: action.description,
        tags: tags(controller_name),
        parameters: parameters(action),
        request_body: request_body(action),
        responses: responses(action),
        security: security(action, security),
        deprecated: action.deprecated
      )
    end

    private def self.tags(name)
      [name] if name
    end

    private def self.parameters(action)
      return unless parameters = action.parameters
      parameters.each_with_object(Array(Parameter).new) do |parameter, obj|
        schema = Schema.new(
          type: parameter.type,
          format: parameter.format,
          default: parameter.default_value
        )

        obj << Parameter.new(
          parameter.name, Parameter::Location.parse(parameter.parameter_location),
          schema, parameter.description, parameter.required, parameter.allow_empty_value,
          parameter.deprecated, parameter.ref
        )
      end
    end

    private def self.request_body(action)
      return unless request = action.request
      content_type = request.content_type || "application/json"
      RequestBody.new(request.description, {content_type => request.media_type})
    end

    private def self.responses(action)
      action.responses.each_with_object(Hash(String, Response).new) do |response, obj|
        obj[response.code] = Response.new(response.description, content: response.content)
      end
    end

    private def self.security(action, security)
      [security] if action.authorization && security
    end

    getter summary : String? = nil
    getter description : String? = nil
    getter tags : Array(String)? = nil
    getter parameters : Array(Parameter)? = nil

    @[JSON::Field(key: "requestBody")]
    getter request_body : RequestBody? = nil

    # List of possible responses as they are returned from executing this operation.
    getter responses : Hash(String, Response)
    getter deprecated : Bool = false
    getter security : Array(Hash(String, Array(String)))? = nil

    # TODO: Add instance vars to initialize
    getter servers : Array(Server)? = nil

    @[JSON::Field(key: "externalDocs")]
    getter external_docs : Example? = nil

    @[JSON::Field(key: "operationId")]
    getter operation_id : String? = nil

    def initialize(@responses : Hash(String, Response), @summary : String? = nil, @description : String? = nil, @tags : Array(String)? = nil,
                   @parameters : Array(Parameter)? = nil, @request_body : RequestBody? = nil,
                   @deprecated : Bool = false, @security : Array(Hash(String, Array(String)))? = nil)
    end
  end
end
