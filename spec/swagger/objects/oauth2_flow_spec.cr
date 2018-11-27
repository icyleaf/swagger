require "../../spec_helper"

describe Swagger::Objects::OAuth2Flow do
  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::OAuth2Flow.new
      raw.authorization_url.should be_nil
      raw.token_url.should be_nil
      raw.refresh_url.should be_nil
      raw.scopes.should be_nil
    end
  end

  describe "#to_json" do
    it "should return empty hash string" do
      raw = Swagger::Objects::OAuth2Flow.new
      raw.to_json.should eq %Q{{}}
    end

    it "should returns OpenAPI spec Link json string" do
      raw = Swagger::Objects::OAuth2Flow.new("123", "456", "789")
      raw.to_json.should eq %Q{{"authorizationUrl":"123","tokenUrl":"456","refreshUrl":"789"}}
    end
  end
end
