# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

> List all changes before release a new version.

## [0.2.2] (2020-10-14)

### Added

- Customize `swagger_path` and add debug mode (defaults to `false`). [#16](https://github.com/icyleaf/swagger/pull/16)

### Fixed

- Fix bearer security_scheme with a incorrect value. [#19](https://github.com/icyleaf/swagger/pull/19) (thanks @[grkek](https://github.com/grkek))

## [0.2.1] (2020-05-06)

### Fixed

- Fixed code usage in README. [#13](https://github.com/icyleaf/swagger/pull/13) (thanks @[lribeiro](https://github.com/lribeiro))
- Fixed missing define @json variable in Swagger HTTP web handler. [#13](https://github.com/icyleaf/swagger/pull/13) (thanks @[lribeiro](https://github.com/lribeiro))
- Compatibility with Crystal 0.34.0

## [0.2.0] (2020-02-28)

### Added

- (**breaking-change**) Make operation's `responses` as **REQUIRED**, to match the specification. [#7](https://github.com/icyleaf/swagger/pull/7)
- Update OpenAPI version to 3.0.3. [#11](https://github.com/icyleaf/swagger/pull/11)

### Changed

- Change location to `Swagger::Objects::Parameter::Location` enum. [#5](https://github.com/icyleaf/swagger/pull/5)
- Use JSDelivr CDN source instead of local swagger-ui assets. [#9](https://github.com/icyleaf/swagger/pull/9)
- Move OpenAPI version to `Swagger::Document`. [#10](https://github.com/icyleaf/swagger/pull/10)

## [0.1.1] (2019-12-27)

### Fixed

- Fix path typo for HTTP Handlers [#3](https://github.com/icyleaf/swagger/pull/3)

## 0.1.0 (2018-12-08)

- First beta version.

[Unreleased]: https://github.com/icyleaf/swagger/compare/v0.2.2...HEAD
[0.2.2]: https://github.com/icyleaf/swagger/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/icyleaf/swagger/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/icyleaf/swagger/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/icyleaf/swagger/compare/v0.1.0...v0.1.1
