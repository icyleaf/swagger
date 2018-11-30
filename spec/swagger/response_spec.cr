require "../spec_helper"

describe Swagger::Response do
  describe "#new" do
    it "should works with reference" do
      raw = Swagger::Response.new("201", "Created", "User", "application/swagger:json")
      raw.code.should eq "201"
      raw.description.should eq "Created"
      raw.media_type.should_not be_nil
      raw.media_type.not_nil!.schema.should be_a(Swagger::Schema)
      raw.media_type.not_nil!.schema.not_nil!.type.should be_nil
      raw.media_type.not_nil!.schema.not_nil!.format.should be_nil
      raw.media_type.not_nil!.schema.not_nil!.required.should be_nil
      raw.media_type.not_nil!.schema.not_nil!.default.should be_nil
      raw.media_type.not_nil!.schema.not_nil!.properties.should be_nil
      raw.media_type.not_nil!.schema.not_nil!.ref.should eq "#/components/schemas/User"
      raw.media_type.not_nil!.example.should be_nil
      raw.media_type.not_nil!.examples.should be_nil
      raw.media_type.not_nil!.encoding.should be_nil
      raw.media_type.not_nil!.ref.should be_nil
      raw.content_type.should eq "application/swagger:json"
    end

    it "should works with schema" do
      raw = Swagger::Response.new("201", "Created", Swagger::Schema.new)
      raw.code.should eq "201"
      raw.description.should eq "Created"
      raw.media_type.should_not be_nil
      raw.media_type.not_nil!.schema.should be_a(Swagger::Schema)
      raw.media_type.not_nil!.schema.not_nil!.type.should be_nil
      raw.media_type.not_nil!.schema.not_nil!.format.should be_nil
      raw.media_type.not_nil!.schema.not_nil!.required.should be_nil
      raw.media_type.not_nil!.schema.not_nil!.default.should be_nil
      raw.media_type.not_nil!.schema.not_nil!.properties.should be_nil
      raw.media_type.not_nil!.schema.not_nil!.ref.should be_nil
      raw.media_type.not_nil!.example.should be_nil
      raw.media_type.not_nil!.examples.should be_nil
      raw.media_type.not_nil!.encoding.should be_nil
      raw.media_type.not_nil!.ref.should be_nil
      raw.content_type.should eq "application/json"
    end

    it "should works with media_type" do
      raw = Swagger::Response.new("200", "Success")
      raw.code.should eq "200"
      raw.description.should eq "Success"
      raw.media_type.should be_nil
      raw.content_type.should eq "application/json"
    end
  end
end
