require "./response_helper"
require "../../../src/swagger/objects/operation"

describe Swagger::Objects::Operation do
  describe ".from" do
    pending
  end

  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::Operation.new SWAGGER_OK_RESPONSE
      raw.responses.should eq SWAGGER_OK_RESPONSE
      raw.summary.should be_nil
      raw.description.should be_nil
      raw.tags.should be_nil
      raw.parameters.should be_nil
      raw.request_body.should be_nil
      raw.deprecated.should be_false
      raw.security.should be_nil

      # TODO: Complete it
      # raw.servers.should be_nil
      # raw.external_docs.should be_nil
      # raw.operation_id.should be_nil
    end
  end

  describe "#to_json" do
    it "should return default hash string" do
      raw = Swagger::Objects::Operation.new SWAGGER_OK_RESPONSE
      raw.to_json.should eq %Q{{"responses":{"200":{"description":"OK"}},"deprecated":false}}
    end

    it "should returns OpenAPI spec Link json string" do
      raw = Swagger::Objects::Operation.new(SWAGGER_OK_RESPONSE, request_body: Swagger::Objects::RequestBody.new)
      raw.to_json.should eq %Q{{"requestBody":{"required":false},"responses":{"200":{"description":"OK"}},"deprecated":false}}
    end
  end
end
