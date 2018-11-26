module Swagger
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

    def initialize(@method : String, @route : String, @summary : String? = nil, @parameters : Array(Parameter)? = nil,
                   @description : String? = nil, @request : Request? = nil, @responses : Array(Response)? = nil,
                   @authorization = false, @deprecated = false)

      unless Objects::PathItem::METHODS.includes?(@method.downcase)
        raise UndefinedMethod.new("Undefined method `#{@method}`, avaiabled in #{Objects::PathItem::METHODS}.")
      end
      @method = @method.downcase
    end
  end
end
