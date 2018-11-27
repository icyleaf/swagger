require "../../spec_helper"

describe Swagger::Objects::SecurityScheme do
  describe ".basic" do
    it "should works" do
      raw = Swagger::Objects::SecurityScheme.basic("Basic Auth")
      raw.type.should eq "http"
      raw.description.should eq "Basic Auth"
      raw.name.should be_nil
      raw.parameter_location.should eq "header"
      raw.scheme.should eq "basic"
      raw.bearer_format.should be_nil
      raw.flows.should be_nil
      raw.open_id_connect_url.should be_nil
      raw.ref.should be_nil
    end
  end

  describe ".bearer" do
    it "should works" do
      raw = Swagger::Objects::SecurityScheme.bearer("Bearer Auth", "JWT")
      raw.type.should eq "http"
      raw.description.should eq "Bearer Auth"
      raw.name.should be_nil
      raw.parameter_location.should eq "header"
      raw.scheme.should eq "basic"
      raw.bearer_format.should eq "JWT"
      raw.flows.should be_nil
      raw.open_id_connect_url.should be_nil
      raw.ref.should be_nil
    end
  end

  describe ".api_key" do
    it "should works" do
      raw = Swagger::Objects::SecurityScheme.api_key("app_key", "query")
      raw.type.should eq "apiKey"
      raw.description.should be_nil
      raw.name.should eq "app_key"
      raw.parameter_location.should eq "query"
      raw.scheme.should be_nil
      raw.bearer_format.should be_nil
      raw.flows.should be_nil
      raw.open_id_connect_url.should be_nil
      raw.ref.should be_nil
    end
  end

  describe ".oauth2" do
    it "should works" do
      raw = Swagger::Objects::SecurityScheme.oauth2([
        Swagger::OAuth2Flow.new("authorizationCode")
      ])

      raw.type.should eq "oauth2"
      raw.description.should be_nil
      raw.name.should be_nil
      raw.parameter_location.should be_nil
      raw.scheme.should be_nil
      raw.bearer_format.should be_nil
      raw.flows.should eq({"authorizationCode" => Swagger::Objects::OAuth2Flow.new})
      raw.open_id_connect_url.should be_nil
      raw.ref.should be_nil
    end
  end

  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::SecurityScheme.new
      raw.type.should be_nil
      raw.description.should be_nil
      raw.name.should be_nil
      raw.parameter_location.should be_nil
      raw.scheme.should be_nil
      raw.bearer_format.should be_nil
      raw.flows.should be_nil
      raw.open_id_connect_url.should be_nil
      raw.ref.should be_nil
    end

    pending "should works with Swagger::Authorization" do

    end
  end

  describe "#to_json" do
    it "should return empty hash string" do
      raw = Swagger::Objects::SecurityScheme.new
      raw.to_json.should eq %Q{{}}
    end
  end
end
