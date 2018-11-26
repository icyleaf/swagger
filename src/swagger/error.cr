module Swagger
  class Error < Exception; end
  class UndefinedMethod < Error; end
  class UndefinedParameterLocation < Error; end
  class UndefinedOAuth2GrantType < Error; end
end
