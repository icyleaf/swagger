module Swagger
  class Error < Exception; end
  class UndefinedMethod < Error; end
  class UndefinedParameterLocation < Error; end
end
