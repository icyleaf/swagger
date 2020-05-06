require "../src/swagger"
require "../src/swagger/http/server"

builder = Swagger::Builder.new(
  title: "Authorization API Demo",
  version: "1.0.0",
  description: "Authorization API Demo document written by Crystal",
  terms_url: "https://github.com/icyleaf/swagger",
  contact: Swagger::Contact.new("icyleaf", "icyleaf.cn@gmail.com", "http://icyleaf.com"),
  authorizations: [
    # List all usages to instance an authorization
    Swagger::Authorization.none,
    Swagger::Authorization.new(Swagger::Authorization::Type::Basic, "Basic Auth"),
    Swagger::Authorization.new("bearer", "Private Token Auth"),
    Swagger::Authorization.jwt(description: "JWT Auth"),
    Swagger::Authorization.api_key(name: "api_key", location: "query", description: "API Key Auth"),
    Swagger::Authorization.cookie(name: "JSESSIONID", description: "Cookie Auth"),
    Swagger::Authorization.oauth2(grant_type: "implicit", authorization_url: "/oauth/authorize", scopes: {
      "read_users"  => "Read users in your account",
      "write_users" => "modify users in your account",
    }, description: "OAuth 2 Auth"),
  ]
)

builder.add(Swagger::Controller.new("Auth", "Authorization", [
  Swagger::Action.new("get", "/access_token", "Get Access Token"),
], external_docs: Swagger::ExternalDocs.new("http://auth.example.com/private_token", "See Details")))

builder.add(Swagger::Controller.new("Users", "User Resources", [
  Swagger::Action.new("get", "/users", "List users", parameters: [
    Swagger::Parameter.new("page", "query", "integer", "Current page"),
    Swagger::Parameter.new("limit", "query", "integer", "How many items to return at one time (max 100)"),
  ], authorization: true),
  Swagger::Action.new("get", "/users/{id}", "Get user by id", parameters: [Swagger::Parameter.new("id", "path")], responses: [
    Swagger::Response.new("200", "Success response"),
    Swagger::Response.new("404", "Not found user"),
  ], authorization: true),
]))

Swagger::HTTP::Server.run(builder.built)
