require "../../spec_helper"

describe Swagger::Objects::Header do
  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::Header.new("Content-Type", "header")
      raw.name.should eq "Content-Type"
      raw.parameter_location.should eq "header"
      raw.required.should be_false
      raw.allow_empty_value.should be_false
      raw.deprecated.should be_false
      raw.ref.should be_nil
    end
  end

  describe "#to_json" do
    it "should return empty hash string" do
      raw = Swagger::Objects::Header.new("Content-Type", "header")
      raw.to_json.should eq %Q{{"name":"Content-Type","in":"header","required":false,"allowEmptyValue":false,"deprecated":false}}
    end
  end
end
