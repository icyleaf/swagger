require "./response_helper"
require "../../../src/swagger/objects/path_item"

describe Swagger::Objects::PathItem do
  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::PathItem.new
      raw.summary.should be_nil
      raw.description.should be_nil
      raw.get.should be_nil
      raw.put.should be_nil
      raw.post.should be_nil
      raw.delete.should be_nil
      raw.options.should be_nil
      raw.head.should be_nil
      raw.patch.should be_nil
      raw.trace.should be_nil
      raw.ref.should be_nil
    end
  end

  describe "#add" do
    it "should works" do
      raw = Swagger::Objects::PathItem.new
      raw.add("get", Swagger::Objects::Operation.new SWAGGER_OK_RESPONSE)
      raw.summary.should be_nil
      raw.description.should be_nil
      raw.get.should eq Swagger::Objects::Operation.new SWAGGER_OK_RESPONSE
      raw.put.should be_nil
      raw.post.should be_nil
      raw.delete.should be_nil
      raw.options.should be_nil
      raw.head.should be_nil
      raw.patch.should be_nil
      raw.trace.should be_nil
      raw.ref.should be_nil
    end

    pending "should print output if give undefined method name" do
      # TODO: "i dont know how to get STDOUT puts"
      # raw = Swagger::Objects::PathItem.new
      # raw.add("fake", Swagger::Objects::Operation.new)
    end
  end

  describe "#to_json" do
    it "should return empty hash string" do
      raw = Swagger::Objects::PathItem.new
      raw.to_json.should eq %Q{{}}
    end
  end
end
