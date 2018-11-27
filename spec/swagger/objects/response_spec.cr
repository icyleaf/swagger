require "../../spec_helper"

describe Swagger::Objects::Response do
  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::Response.new("response")
      raw.description.should eq "response"
      raw.headers.should be_nil
      raw.content.should be_nil
      raw.links.should be_nil
      raw.ref.should be_nil
    end
  end

  describe "#to_json" do
    it "should return default hash string" do
      raw = Swagger::Objects::Response.new("response")
      raw.to_json.should eq %Q{{"description":"response"}}
    end
  end
end
