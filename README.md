# Swagger

![Project Status](https://img.shields.io/badge/status-WIP-yellow.svg)
[![Language](https://img.shields.io/badge/language-crystal-776791.svg)](https://github.com/crystal-lang/crystal)
[![Tag](https://img.shields.io/github/tag/icyleaf/swagger.svg)](https://github.com/icyleaf/swagger/blob/master/CHANGELOG.md)
[![Source](https://img.shields.io/badge/source-github-brightgreen.svg)](https://github.com/icyleaf/swagger/)
[![Document](https://img.shields.io/badge/document-api-brightgreen.svg)](https://icyleaf.github.io/swagger/)
[![Build Status](https://img.shields.io/circleci/project/github/icyleaf/swagger/master.svg?style=flat)](https://circleci.com/gh/icyleaf/swagger)

Swagger is low-level library which generate output compatible with [Swagger / OpenAPI Spec 3.0.1](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md),
and wrapped many friendly API let developer understand and use it easier.

## Installation

```yaml
dependencies:
  swagger:
    github: icyleaf/swagger
```

## Quick look

```crystal
require "swagger"

builder = Swagger::Builder.new(
  title: "App API",
  version: "1.0.0",
  description: "This is a sample api for users",
  terms: "http://yourapp.com/terms",
  contact: Swagger::Contact.new("icyleaf", "icyleaf.cn@gmail.com", "http://icyleaf.com"),
  license: Swagger::License.new("MIT", "https://github.com/icyleaf/swagger/blob/master/LICENSE"),
  authorizations: [
    Swagger::Authorization.jwt(description: "Use JWT Auth"),
  ]
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

## Structure

```
.
├── action.cr
├── authorization.cr
├── builder.cr
├── controller.cr
├── error.cr
├── object.cr
├── parameter.cr
├── property.cr
├── request.cr
├── response.cr
├── server.cr
├── http                          # HTTP libraries
│   ├── assets
│   ├── handers
│   ├── handler.cr
│   ├── server.cr
│   └── views
└── objects                       # OpenAPI objects
    ├── components.cr
    ├── document.cr
    ├── encoding.cr
    ├── example.cr
    ├── external_docs.cr
    ├── header.cr
    ├── info.cr
    ├── link.cr
    ├── media_type.cr
    ├── operation.cr
    ├── parameter.cr
    ├── path_item.cr
    ├── property.cr
    ├── request_body.cr
    ├── response.cr
    ├── schema.cr
    ├── security_scheme.cr
    ├── server.cr
    └── tag.cr
```

## Running on web

Swagger provids a built-in web server, if you have no idea how to preview it:

###
```crystal
require "swagger"
require "swagger/http/server"

# made your document
document = builder.built

# Run web server
Swagger::HTTP::Server.run(builder.built)
```

## Integrating

Swagger has two HTTP handlers which you can integrate it to mostly Crystal framework (like kemal, amber, lucky etc):

- Swagger::HTTP::APIHandler
- Swagger::HTTP::WebHandler

## Examples

See more [examples](/examples).

## Todo

- [x] openapi
- [x] Info Object
- [x] Paths Object
  - [x] PathItem Object
    - [x] Parameter Object
    - [x] RequestBody Object
    - [x] Responses Object
    - [x] Security Object
    - [x] Tag Object
- [x] Tags Object
- [x] Servers Objec
  - [x] ServerVariables Object
- [x] Security Object
- [ ] Components Object
  - [x] Schemas Object
  - [x] SecuritySchemes Object
    - [x] Basic
    - [x] Bearer (include JWT)
    - [x] APIKey
    - [ ] OAuth2
- [ ] ExternalDocs Object

## Donate

Swagger is a open source, collaboratively funded project. If you run a business and are using Swagger in a revenue-generating product,
it would make business sense to sponsor Swagger development. Individual users are also welcome to make a one time donation
if Swagger has helped you in your work or personal projects.

You can donate via [Paypal](https://www.paypal.me/icyleaf/5).

## How to Contribute

Your contributions are always welcome! Please submit a pull request or create an issue to add a new question, bug or feature to the list.

Here is a throughput graph of the repository for the last few weeks:

All [Contributors](https://github.com/icyleaf/swagger/graphs/contributors) are on the wall.

## You may also like

- [halite](https://github.com/icyleaf/halite) - HTTP Requests Client with a chainable REST API, built-in sessions and middlewares.
- [totem](https://github.com/icyleaf/totem) - Load and parse a configuration file or string in JSON, YAML, dotenv formats.
- [markd](https://github.com/icyleaf/markd) - Yet another markdown parser built for speed, Compliant to CommonMark specification.
- [poncho](https://github.com/icyleaf/poncho) - A .env parser/loader improved for performance.
- [popcorn](https://github.com/icyleaf/popcorn) - Easy and Safe casting from one type to another.
- [fast-crystal](https://github.com/icyleaf/fast-crystal) - 💨 Writing Fast Crystal 😍 -- Collect Common Crystal idioms.

## License

[MIT License](https://github.com/icyleaf/swagger/blob/master/LICENSE) © icyleaf
