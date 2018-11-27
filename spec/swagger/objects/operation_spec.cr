require "../../spec_helper"

describe Swagger::Objects::Operation do
  describe ".from" do
    pending
  end

  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::Operation.new
      raw.summary.should be_nil
      raw.description.should be_nil
      raw.tags.should be_nil
      raw.parameters.should be_nil
      raw.request_body.should be_nil
      raw.responses.should be_nil
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
      raw = Swagger::Objects::Operation.new
      raw.to_json.should eq %Q{{"deprecated":false}}
    end

    it "should returns OpenAPI spec Link json string" do
      raw = Swagger::Objects::Operation.new(request_body: Swagger::Objects::RequestBody.new)
      raw.to_json.should eq %Q{{"requestBody":{"required":false},"deprecated":false}}
    end
  end
end
