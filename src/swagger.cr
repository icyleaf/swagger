require "json"
require "./swagger/*"

module Swagger
  VERSION = "0.1.0"

  OPENAPI_MAJAR_VERSION = "3"
  OPENAPI_VERSION       = "3.0.1"

  alias Document = Objects::Document
  alias Info = Objects::Info
  alias Contact = Objects::Info::Contact
  alias License = Objects::Info::License
  alias Schema = Objects::Schema
  alias MediaType = Objects::MediaType
  alias ExternalDocs = Objects::ExternalDocs
end
