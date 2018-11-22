# Swagger

Swagger contains a OpenAPI / Swagger universal documentation generator and server handler.

Swagger is low-level library which generate output compatible with [Swagger / OpenAPI Spec 3.0.1](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md).

## Quick look

```crystal
require "swagger"

builder = Swagger::Builder.new(
  title: "App API",
  version: "1.0.0",
  description: "This is a sample api for users",
  terms: URI.parse("http://yourapp.com/terms"),
  contact: Swagger::Contact.new("icyleaf", "icyleaf.cn@gmail.com", URI.parse("http://icyleaf.com")),
  license: Swagger::License.new("MIT", URI.parse("https://github.com/icyleaf/swagger/blob/master/LICENSE"))
)

builder.add(Swagger::Controller.new("Users", "User resources", [
  Swagger::Action.new("get", "/users", "All users"),
  Swagger::Action.new("get", "/users/{id}", "Get user by id", parameters: [
    Swagger::Parameter.new("id", "path")
  ], responses: [
    Swagger::Response.new("200", "Success response"),
    Swagger::Response.new("404", "Not found user")
  ]),
  Swagger::Action.new("post", "/users", "Create User", responses: [
    Swagger::Response.new("201", "Return user resource after created"),
    Swagger::Response.new("401", "Unauthorizated")
  ])
]))

document = builder.built
p document

```

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  swagger:
    github: icyleaf/swagger
```
2. Run `shards install`

## Usage

```crystal
require "swagger"
```

## Todo

- [x] Version Object
- [x] Info Object
- [x] Paths Object
  - [x] PathItem Object
    - [ ] Parameter Object
    - [ ] RequestBody Object
    - [ ] Responses Object
    - [ ] Security Object
    - [x] Tag Object
- [x] Tags Object
- [ ] Components Object
  - [ ] Schemas Object
  - [ ] SecuritySchemes Object
- [x] Servers Object
  - [x] ServerVariables Object

## Contributing

1. Fork it (<https://github.com/icyleaf/swagger/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [icyleaf](https://github.com/icyleaf) - creator and maintainer
