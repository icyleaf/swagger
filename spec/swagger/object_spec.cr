require "../spec_helper"

describe Swagger::Object do
  describe "#new" do
    it "should works" do
      properties = [
        Swagger::Property.new("id", "integer", "int32", example: 1),
        Swagger::Property.new("nickname", example: "icyleaf wang"),
        Swagger::Property.new("username", example: "icyleaf"),
        Swagger::Property.new("email", example: "icyleaf.cn@gmail.com"),
        Swagger::Property.new("bio", "Personal bio"),
      ]
      raw = Swagger::Object.new("User", "object", properties)
      raw.name.should eq "User"
      raw.type.should eq "object"
      raw.properties.should_not be_nil
      raw.properties.try &.size.should eq 5
    end

    it "should supports the type array with items as an object" do
      raw = Swagger::Object.new(
        "CommentList",
        "array",
        items: Swagger::Object.new(
          "Comment",
          "object",
        )
      )
      raw.type.should eq("array")
      raw.properties.should be_nil
      raw.items.class.should eq(Swagger::Object)
    end

    it "should supports the type array with items as a ref" do
      raw = Swagger::Object.new(
        "CommentList",
        "array",
        items: "Comment",
      )
      raw.type.should eq("array")
      raw.properties.should be_nil
      raw.items.should eq("Comment")
    end
  end
end
