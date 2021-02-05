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

    it "should supports the array type with items as an Object" do
      raw = Swagger::Property.new(
        "comments",
        "array",
        items: Swagger::Object.new("Comment", "object")
      )
      raw.type.should eq("array")
      raw.items.class.should eq(Swagger::Object)
    end

    it "should supports the array type with items as a ref" do
      raw = Swagger::Property.new(
        "comments",
        "array",
        items: "Comment",
      )
      raw.type.should eq("array")
      raw.items.should eq("Comment")
    end
  end
end
