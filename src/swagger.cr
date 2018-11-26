require "json"
require "./swagger/*"

module Swagger
  VERSION = "0.1.0"

  OPENAPI_MAJAR_VERSION = "3"
  OPENAPI_VERSION = "3.0.1"

  alias ExternalDocs = Object::ExternalDocs
  alias Contact = Object::Info::Contact
  alias License = Object::Info::License
end
