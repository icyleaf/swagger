require "../../spec_helper"

describe Swagger::Objects::Encoding do
  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::Encoding.new
      raw.content_type.should be_nil
      raw.headers.should be_nil
      raw.style.should be_nil
      raw.explode.should be_false
      raw.allow_reserved.should be_false
    end
  end

  describe "#to_json" do
    it "should return empty hash string" do
      raw = Swagger::Objects::Encoding.new
      raw.to_json.should eq %Q{{"explode":false,"allowReserved":false}}
    end
  end
end
