require "../spec_helper"

describe Swagger::Request do
  describe "#new" do
    it "should works with reference" do
      raw = Swagger::Request.new("User", "User struct", "application/x-www-form-urlencoded")
      raw.media_type.should_not be_nil
      raw.media_type.schema.should be_a(Swagger::Schema)
      raw.media_type.schema.not_nil!.type.should be_nil
      raw.media_type.schema.not_nil!.format.should be_nil
      raw.media_type.schema.not_nil!.required.should be_nil
      raw.media_type.schema.not_nil!.default.should be_nil
      raw.media_type.schema.not_nil!.properties.should be_nil
      raw.media_type.schema.not_nil!.ref.should eq "#/components/schemas/User"
      raw.media_type.example.should be_nil
      raw.media_type.examples.should be_nil
      raw.media_type.encoding.should be_nil
      raw.media_type.ref.should be_nil
      raw.description.should eq "User struct"
      raw.content_type.should eq "application/x-www-form-urlencoded"
    end

    it "should works with properties" do
      raw = Swagger::Request.new([
        Swagger::Property.new("username", "string", "User name"),
        Swagger::Property.new("email", "string", ""),
        Swagger::Property.new("password"),
        Swagger::Property.new("confirm_password"),
      ], "User form data", "application/x-www-form-urlencoded")

      raw.media_type.should_not be_nil
      raw.media_type.schema.should be_a(Swagger::Schema)
      raw.media_type.schema.not_nil!.type.should eq "object"
      raw.media_type.schema.not_nil!.format.should be_nil
      raw.media_type.schema.not_nil!.required.should eq Array(String).new
      raw.media_type.schema.not_nil!.default.should be_nil
      raw.media_type.schema.not_nil!.properties.should be_a Hash(String, Swagger::Objects::Property)
      raw.media_type.schema.not_nil!.properties.not_nil!.size.should eq 4
      raw.media_type.schema.not_nil!.ref.should be_nil
      raw.media_type.example.should be_nil
      raw.media_type.examples.should be_nil
      raw.media_type.encoding.should be_nil
      raw.media_type.ref.should be_nil
      raw.description.should eq "User form data"
      raw.content_type.should eq "application/x-www-form-urlencoded"
    end

    it "should works with media type" do
      raw = Swagger::Request.new(Swagger::MediaType.new)
      raw.media_type.schema.should be_nil
      raw.media_type.example.should be_nil
      raw.media_type.examples.should be_nil
      raw.media_type.encoding.should be_nil
      raw.media_type.ref.should be_nil
      raw.description.should be_nil
      raw.content_type.should be_nil
    end
  end
end
