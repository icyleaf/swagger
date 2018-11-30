require "../spec_helper"

describe Swagger::Parameter do
  describe "#new" do
    it "should works" do
      raw = Swagger::Parameter.new("username", "query")
      raw.name.should eq "username"
      raw.parameter_location.should eq "query"

      raw.format.should be_nil
      raw.type.should eq "string"
      raw.description.should be_nil
      raw.default_value.should be_nil
      raw.required.should be_false
      raw.allow_empty_value.should be_false
      raw.deprecated.should be_false
      raw.ref.should be_nil
    end
  end
end
