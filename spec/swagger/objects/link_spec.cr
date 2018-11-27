require "../../spec_helper"

describe Swagger::Objects::Link do
  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::Link.new
      raw.operation_ref.should be_nil
      raw.operation_id.should be_nil
      raw.parameters.should be_nil
      raw.request_body.should be_nil
      raw.description.should be_nil
      raw.server.should be_nil
      raw.ref.should be_nil
    end
  end

  describe "#to_json" do
    it "should return empty hash string" do
      raw = Swagger::Objects::Link.new
      raw.to_json.should eq %Q{{}}
    end

    it "should returns OpenAPI spec Link json string" do
      raw = Swagger::Objects::Link.new("foo", "bar", request_body: "name=foobar")
      raw.to_json.should eq %Q{{"operationRef":"foo","operationId":"bar","requestBody":"name=foobar"}}
    end
  end
end
