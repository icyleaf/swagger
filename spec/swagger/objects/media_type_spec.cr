require "../../spec_helper"

describe Swagger::Objects::MediaType do
  describe ".use_reference" do
    it "should works" do
      raw = Swagger::Objects::MediaType.use_reference("User")
      raw.schema.should eq Swagger::Objects::Schema.use_reference("User")
      raw.example.should be_nil
      raw.examples.should be_nil
      raw.encoding.should be_nil
      raw.ref.should be_nil
    end
  end

  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::MediaType.new
      raw.schema.should be_nil
      raw.example.should be_nil
      raw.examples.should be_nil
      raw.encoding.should be_nil
      raw.ref.should be_nil
    end
  end

  describe "#to_json" do
    it "should return empty hash string" do
      raw = Swagger::Objects::MediaType.new
      raw.to_json.should eq %Q{{}}
    end
  end
end
