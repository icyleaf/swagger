require "../../spec_helper"

describe Swagger::Objects::RequestBody do
  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::RequestBody.new
      raw.description.should be_nil
      raw.content.should be_nil
      raw.required.should be_false
      raw.ref.should be_nil
    end
  end

  describe "#to_json" do
    it "should return default hash string" do
      raw = Swagger::Objects::RequestBody.new
      raw.to_json.should eq %Q{{"required":false}}
    end
  end
end
