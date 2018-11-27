require "../spec_helper"

describe Swagger::Action do
  describe "#new" do
    it "should works" do
      raw = Swagger::Action.new("get", "/users")
      raw.method.should eq "get"
      raw.route.should eq "/users"
      raw.summary.should be_nil
      raw.description.should be_nil
      raw.parameters.should be_nil
      raw.request.should be_nil
      raw.responses.should be_nil
      raw.authorization.should be_false
      raw.deprecated.should be_false
    end

    it "should stored downcase method" do
      raw = Swagger::Action.new("GET", "/users")
      raw.method.should eq "get"
    end

    {% for ivar in Swagger::Objects::PathItem::METHODS %}
      it "should define {{ ivar.id }} method" do
        raw = Swagger::Action.new("{{ ivar.id }}", "/users")
        raw.method.should eq "{{ ivar.id }}"
        raw.route.should eq "/users"
      end
    {% end %}

    it "throws an exception with undefined method" do
      expect_raises Swagger::UndefinedMethod do
        Swagger::Action.new("fake", "/users")
      end
    end
  end
end
