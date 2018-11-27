require "../../spec_helper"

describe Swagger::Objects::Parameter do
  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::Parameter.new("user_id", "query", Swagger::Objects::Schema.use_reference("User"))
      raw.name.should eq "user_id"
      raw.parameter_location.should eq "query"
      raw.schema.should eq Swagger::Objects::Schema.use_reference("User")
      raw.description.should be_nil
      raw.required.should be_false
      raw.allow_empty_value.should be_false
      raw.deprecated.should be_false
      raw.ref.should be_nil
    end
  end

  describe "#to_json" do
    it "should return default hash string" do
      raw = Swagger::Objects::Parameter.new("user_id", "query", Swagger::Objects::Schema.use_reference("User"))
      raw.to_json.should eq %Q{{"name":"user_id","schema":{"$ref":"#/components/schemas/User"},"in":"query","required":false,"allowEmptyValue":false,"deprecated":false}}
    end
  end
end
