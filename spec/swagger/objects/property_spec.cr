require "../../spec_helper"

describe Swagger::Objects::Property do
  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::Property.new("string")
      raw.type.should eq "string"
      raw.description.should be_nil
      raw.default.should be_nil
      raw.example.should be_nil
      raw.required.should be_nil
    end
  end

  describe "#to_json" do
    it "should return default hash string" do
      raw = Swagger::Objects::Property.new("string")
      raw.to_json.should eq %Q{{"type":"string"}}
    end
  end
end
