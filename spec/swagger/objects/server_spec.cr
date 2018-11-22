require "../../spec_helper"

describe Swagger::Object::Server do
  describe "#new" do
    it "should works" do
      raw = Swagger::Object::Server.new("http://example.com", "Production")
      raw.url.should eq "http://example.com"
      raw.description.should eq "Production"
      raw.variables.should be_nil
    end

    it "should accept url only" do
      raw = Swagger::Object::Server.new("http://example.com")
      raw.url.should eq "http://example.com"
      raw.description.should be_nil
      raw.variables.should be_nil
    end

  #   it "should accept pass argument by namedtupled style" do
  #     raw = Swagger::Contact.new(name: "foo", url: URI.parse("http://example.com"))
  #     raw.name.should eq "foo"
  #     raw.email.should be_nil
  #     raw.url.to_s.should eq "http://example.com"
  #   end
  end

  describe "#to_json" do
    raw = Swagger::Object::Server.new("http://example.com", "Production")
    raw.to_json.should eq %Q{{"url":"http://example.com","description":"Production"}}

    raw = Swagger::Object::Server.new("http://example.com")
    raw.to_json.should eq %Q{{"url":"http://example.com"}}
  end
end
