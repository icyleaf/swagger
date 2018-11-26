require "../../spec_helper"

describe Swagger::Objects::Info::Contact do
  describe "use alias" do
    it "should equal with alias" do
      a = Swagger::Objects::Info::Contact.new("foo", "foo@example.com", "http://example.com")
      b = Swagger::Contact.new("foo", "foo@example.com", "http://example.com")
      a.should eq b
    end
  end

  describe "#new" do
    it "should works" do
      raw = Swagger::Contact.new("foo", "foo@example.com", "http://example.com")
      raw.name.should eq "foo"
      raw.email.should eq "foo@example.com"
      raw.url.should eq "http://example.com"
    end

    it "should accept name only" do
      raw = Swagger::Contact.new("foo")
      raw.name.should eq "foo"
      raw.email.should be_nil
      raw.url.should be_nil
    end

    it "should accept pass argument by namedtupled style" do
      raw = Swagger::Contact.new(name: "foo", url: "http://example.com")
      raw.name.should eq "foo"
      raw.email.should be_nil
      raw.url.should eq "http://example.com"
    end
  end

  describe "#to_json" do
    raw = Swagger::Contact.new("foo", "foo@example.com", "http://example.com")
    raw.to_json.should eq %Q{{"name":"foo","email":"foo@example.com","url":"http://example.com"}}
  end
end

describe Swagger::Objects::Info::License do
  describe "use alias" do
    it "should equal with alias" do
      a = Swagger::Objects::Info::License.new("MIT", "http://example.com")
      b = Swagger::License.new("MIT", "http://example.com")
      a.should eq b
    end
  end

  describe "#new" do
    it "should works" do
      raw = Swagger::License.new("MIT", "http://example.com")
      raw.name.should eq "MIT"
      raw.url.should eq "http://example.com"
    end

    it "should accept name only" do
      raw = Swagger::License.new("Apache 2.0")
      raw.name.should eq "Apache 2.0"
      raw.url.should be_nil
    end

    it "should accept pass argument by namedtupled style" do
      raw = Swagger::Contact.new(name: "GPL v3", url: "http://example.com")
      raw.name.should eq "GPL v3"
      raw.url.should eq "http://example.com"
    end
  end

  describe "#to_json" do
    raw = Swagger::Contact.new(name: "GPL v3", url: "http://example.com")
    raw.to_json.should eq %Q{{"name":"GPL v3","url":"http://example.com"}}
  end

  # describe "use shortcuts" do
  #   {% for ivar, iurl in Swagger::License::KNOWN_LICENSES %}
  #     it ".{{ ivar.id }}" do
  #       raw = Swagger::License.{{ ivar.id }}
  #       raw.name.should eq {{ ivar.id.upcase.stringify }}
  #       raw.url.to_s.should eq {{ iurl.id.stringify }}
  #     end
  #   {% end %}
  # end
end

describe Swagger::Objects::Info do
  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::Info.new("API", "1.0.0", "Example API document")
      raw.title.should eq "API"
      raw.version.should eq "1.0.0"
      raw.description.should eq "Example API document"
      raw.terms_url.should be_nil
      raw.contact.should be_nil
      raw.license.should be_nil
    end

    it "should accept pass argument by namedtupled style" do
      raw = Swagger::Objects::Info.new("API", "1.0.0", "Example API document", license: Swagger::License.new("MIT"))
      raw.title.should eq "API"
      raw.version.should eq "1.0.0"
      raw.description.should eq "Example API document"
      raw.terms_url.should be_nil
      raw.contact.should be_nil
      raw.license.not_nil!.name.should eq "MIT"
    end
  end

  describe "#to_json" do
    raw = Swagger::Objects::Info.new("API", "1.0.0", "Example API document", license: nil)
    raw.to_json.should eq %Q{{"title":"API","version":"1.0.0","description":"Example API document"}}
  end
end
