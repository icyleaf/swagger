require "kemal"
require "../../src/swagger"
require "../../src/swagger/http/handler"

user = {
  name: "foo",
  age:  30,
}

get "/users" do |env|
  page = env.params.query["page"]?.try &.to_i || 1
  limit = env.params.query["limit"]?.try &.to_i || 25

  total_pages = 50
  entry = Array(NamedTuple(name: String, age: Int32)).new.tap do |obj|
    limit.times do
      obj << user
    end
  end

  env.response.headers["Content-Type"] = "application/json"
  {
    total:        total_pages,
    current_page: page,
    entry:        entry,
  }.to_json
end

post "/users" do |env|
  env.response.headers["Content-Type"] = "application/json"
  env.response.status_code = 201
  {
    name: env.params.body["name"],
    age:  env.params.body["age"],
  }.to_json
end

get "/users/:id" do |env|
  env.response.headers["Content-Type"] = "application/json"
  user.to_json
end

delete "/users/:id" do |env|
  env.response.headers["Content-Type"] = "application/json"
  true.to_json
end

builder = Swagger::Builder.new(
  title: "Kemal App API Demo",
  version: "1.0.0",
  description: "Kemal App API Demo document written by Crystal",
  terms_url: "https://github.com/icyleaf/swagger",
  license: Swagger::License.new("MIT", "https://opensource.org/licenses/MIT"),
  contact: Swagger::Contact.new("icyleaf", "icyleaf.cn@gmail.com", "http://icyleaf.com")
)

builder.add(Swagger::Controller.new("Users", "User Resources", [
  Swagger::Action.new("get", "/users", description: "List users", parameters: [
    Swagger::Parameter.new("page", "query", "integer", "Current page", default_value: 1),
    Swagger::Parameter.new("limit", "query", "integer", "How many items to return at one time (max 100)", default_value: 10),
  ], responses: [
    Swagger::Response.new("200", "Success response"),
  ]),
  Swagger::Action.new("get", "/users/{id}", description: "Get user by id", parameters: [Swagger::Parameter.new("id", "path")], responses: [
    Swagger::Response.new("200", "Success response"),
    Swagger::Response.new("404", "Not found user"),
  ]),
  Swagger::Action.new("post", "/users", description: "Create a user",
    request: Swagger::Request.new([
      Swagger::Property.new("name", required: true, description: "The name of user"),
      Swagger::Property.new("age", "integer", format: "int32", required: true, description: "The age of user", default_value: 20),
    ], "Form data", "application/x-www-form-urlencoded"),
    responses: [
      Swagger::Response.new("200", "Success response"),
      Swagger::Response.new("404", "Not found user"),
    ]
  ),
  Swagger::Action.new("delete", "/users/{id}", description: "Get user by id", parameters: [Swagger::Parameter.new("id", "path")], responses: [
    Swagger::Response.new("200", "Success response"),
    Swagger::Response.new("404", "Not found user"),
  ]),
]))

builder.add(Swagger::Server.new("http://localhost:{port}/", "Alias Name", [
  Swagger::Server::Variable.new("port", "3030", ["3030", "3000"], "API port"),
]))

builder.add(Swagger::Server.new("http://0.0.0.0:{port}/", "IP Address", [
  Swagger::Server::Variable.new("port", "3030", ["3030", "3000"], "API port"),
]))

swagger_api_endpoint = "http://localhost:3030"
swagger_web_entry_path = "/swagger"
swagger_api_handler = Swagger::HTTP::APIHandler.new(builder.built, swagger_api_endpoint)
swagger_web_handler = Swagger::HTTP::WebHandler.new(swagger_web_entry_path, swagger_api_handler.api_url)

add_handler swagger_api_handler
add_handler swagger_web_handler

Kemal.run(3030)
