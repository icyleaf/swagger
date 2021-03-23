require "../../spec_helper"

describe Swagger::Objects::Schema do
  describe ".use_reference" do
    it "should works" do
      raw = Swagger::Objects::Schema.use_reference("User")
      raw.ref.should eq "#/components/schemas/User"
    end
  end

  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::Schema.new
      raw.type.should be_nil
      raw.format.should be_nil
      raw.required.should be_nil
      raw.default.should be_nil
      raw.properties.should be_nil
      raw.ref.should be_nil
    end

    it "supports array" do
      raw = Swagger::Objects::Schema.new(
        type: "array",
        items: Swagger::Objects::Schema.use_reference("SomeSchema")
      )
      raw.type.should eq("array")
      raw.items.should_not be_nil
      raw.items.try &.ref.should eq("#/components/schemas/SomeSchema")
    end
  end

  describe "#to_json" do
    it "should return empty hash string" do
      raw = Swagger::Objects::Schema.new
      raw.to_json.should eq %Q{{}}
    end
  end
end
