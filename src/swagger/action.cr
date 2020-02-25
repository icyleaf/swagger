module Swagger
  # Define a action
  #
  # ```
  # Swagger::Action.new("get", "/users", "List Users", [
  #   Swagger::Parameter.new("page", "query", "integer", "Current page", default_value: 1, format: "int32"),
  #   Swagger::Parameter.new("limit", "query", "integer", "How many items to return at one time (max 100)", default_value: 50, format: "int32"),
  # ])
  # ```
  struct Action
    property method
    property route
    property summary
    property description
    property parameters
    property request
    property responses
    property authorization
    property deprecated

    def initialize(@method : String, @route : String, @responses : Array(Response), @summary : String? = nil, @parameters : Array(Parameter)? = nil,
                   @description : String? = nil, @request : Request? = nil,
                   @authorization = false, @deprecated = false)
      unless Objects::PathItem::METHODS.includes?(@method.downcase)
        raise UndefinedMethod.new("Undefined method `#{@method}`, avaiabled in #{Objects::PathItem::METHODS}.")
      end
      @method = @method.downcase
    end
  end
end
