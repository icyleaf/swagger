require "../spec_helper"

describe Swagger::Property do
  describe "#new" do
    it "should works" do
      raw = Swagger::Property.new("username")
      raw.name.should eq "username"
      raw.type.should eq "string"
      raw.format.should be_nil
      raw.description.should be_nil
      raw.default_value.should be_nil
      raw.required.should be_nil
      raw.example.should be_nil
    end
  end
end
