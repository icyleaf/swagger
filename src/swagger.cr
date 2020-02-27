require "json"
require "./swagger/*"

module Swagger
  alias Document = Objects::Document
  alias Info = Objects::Info
  alias Contact = Objects::Info::Contact
  alias License = Objects::Info::License
  alias Schema = Objects::Schema
  alias MediaType = Objects::MediaType
  alias ExternalDocs = Objects::ExternalDocs
end
