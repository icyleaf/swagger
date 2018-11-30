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
      raw.properties.size.should eq 5
    end
  end
end
