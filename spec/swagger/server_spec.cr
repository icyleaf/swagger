require "../spec_helper"

describe Swagger::Server do
  describe "#new" do
    it "should works" do
      raw = Swagger::Server.new("http://api.example.com")
      raw.url.should eq "http://api.example.com"
      raw.description.should be_nil
      raw.variables.should be_nil
    end
  end
end
