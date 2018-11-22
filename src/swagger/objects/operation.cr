module Swagger::Object
  struct Operation
    include JSON::Serializable

    def self.from(action : Action, controller_name : String? = nil)
      new(action.summary, action.description, tags(controller_name), action.parameters,
          action.request, responses(action.responses), action.authorization)
    end

    def self.tags(name)
      [name] if name
    end

    def self.responses(responses)
      return unless values = responses
      values.each_with_object(Hash(String, Response).new) do |response, obj|
        reference : String? = nil
        obj[response.code] = Response.new(response.description)
      end
    end

  #   func built() -> [String: OpenAPIResponse]? {
  #     var openAPIResponses: [String: OpenAPIResponse] = [:]

  #     for apiResponse in apiResponses {

  #         var objectTypeReference: String? = nil
  #         var isArray: Bool = false

  #         if let apiResponseObject = apiResponse.object {
  #             objectTypeReference = self.objectReference(for: apiResponseObject)
  #         }

  #         if let apiResponseArray = apiResponse.array {
  #             isArray = true
  #             objectTypeReference = self.objectReference(for: apiResponseArray)
  #         }

  #         if objectTypeReference != nil {

  #             var openAPISchema: OpenAPISchema?
  #             if isArray {
  #                 let objectInArraySchema = OpenAPISchema(ref: objectTypeReference!)
  #                 openAPISchema = OpenAPISchema(type: "array", items: objectInArraySchema)
  #             } else {
  #                 openAPISchema = OpenAPISchema(ref: objectTypeReference!)
  #             }

  #             let contentType = apiResponse.contentType ?? "application/json"
  #             let openAPIResponseSchema = OpenAPIMediaType(schema: openAPISchema)

  #             let openAPIResponse = OpenAPIResponse(
  #                 description: apiResponse.description,
  #                 content: [contentType: openAPIResponseSchema]
  #             )

  #             openAPIResponses[apiResponse.code] = openAPIResponse
  #         } else {
  #             let openAPIResponse = OpenAPIResponse(description: apiResponse.description)
  #             openAPIResponses[apiResponse.code] = openAPIResponse
  #         }
  #     }

  #     return openAPIResponses
  # }

  # func objectReference(for type: Any.Type) -> String {
  #     let mirrorObjectType = String(describing: type)
  #     let objectTypeReference = "#/components/schemas/\(mirrorObjectType)"
  #     return objectTypeReference
  # }

    getter summary : String? = nil
    getter description : String? = nil
    getter tags : Array(String)? = nil
    getter parameters : Array(Parameter)? = nil

    @[JSON::Field(key: "requestBody")]
    getter request_body : String? = nil

    getter responses : Hash(String, Response)? = nil
    getter deprecated : Bool = false

    # TODO: Add instace vars to initialize
    getter security : Array(Hash(String, String)) ? = nil
    getter servers : Array(Server)? = nil

    @[JSON::Field(key: "externalDocs")]
    getter external_docs : Example? = nil

    @[JSON::Field(key: "operationId")]
    getter operation_id : String? = nil

    def initialize(@summary : String? = nil, @description : String? = nil, @tags : Array(String)? = nil,
                   @parameters : Array(Parameter)? = nil, @request_body : String? = nil, @responses : Hash(String, Response)? = nil,
                   @deprecated : Bool = false)
    end
  end
end
