require "../../spec_helper"

describe Swagger::Objects::Example do
  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::Example.new
      raw.summary.should be_nil
      raw.description.should be_nil
      raw.value.should be_nil
      raw.external_value.should be_nil
      raw.ref.should be_nil
    end
  end

  describe "#to_json" do
    it "should return empty hash string" do
      raw = Swagger::Objects::Example.new
      raw.to_json.should eq %Q{{}}
    end

    it "should return json string" do
      raw = Swagger::Objects::Example.new(ref: "hello")
      raw.to_json.should eq %Q{{"$ref":"hello"}}
    end
  end
end
