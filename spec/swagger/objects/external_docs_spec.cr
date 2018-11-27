require "../../spec_helper"

describe Swagger::Objects::ExternalDocs do
  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::ExternalDocs.new("http://example.com")
      raw.url.should eq "http://example.com"
      raw.description.should be_nil

      raw = Swagger::Objects::ExternalDocs.new("http://example.com", "description")
      raw.url.should eq "http://example.com"
      raw.description.should eq "description"
    end
  end

  describe "#to_json" do
    it "should return empty hash string" do
      raw = Swagger::Objects::ExternalDocs.new("http://example.com")
      raw.to_json.should eq %Q{{"url":"http://example.com"}}

      raw = Swagger::Objects::ExternalDocs.new("http://example.com", "description")
      raw.to_json.should eq %Q{{"url":"http://example.com","description":"description"}}
    end
  end
end
