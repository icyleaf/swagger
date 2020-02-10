require "../../spec_helper"

describe Swagger::Objects::Components do
  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::Components.new
      raw.schemas.should be_nil
      raw.responses.should be_nil
      raw.parameters.should be_nil
      raw.examples.should be_nil
      raw.request_bodies.should be_nil
      raw.headers.should be_nil
      raw.security_schemes.should be_nil
      raw.links.should be_nil
      raw.callbacks.should be_nil
    end
  end

  describe "#to_json" do
    it "should return empty hash string" do
      raw = Swagger::Objects::Components.new
      raw.to_json.should eq %Q{{}}

      raw = Swagger::Objects::Components.new(schemas: {
        "user" => Swagger::Objects::Schema.use_reference("UserInfo"),
      })
      raw.to_json.should eq %Q{{"schemas":{"user":{"$ref":"#/components/schemas/UserInfo"}}}}
    end
  end
end
