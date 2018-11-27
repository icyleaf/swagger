require "../../spec_helper"

describe Swagger::Objects::Tag do
  describe "#new" do
    it "should works" do
      raw = Swagger::Objects::Tag.new("Pets")
      raw.name.should eq "Pets"
      raw.description.should be_nil
      raw.external_docs.should be_nil
    end
  end

  describe "#to_json" do
    it "should works" do
      raw = Swagger::Objects::Tag.new("Pets")
      raw.to_json.should eq %Q{{"name":"Pets"}}
    end
  end
end
