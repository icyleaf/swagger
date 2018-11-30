require "../spec_helper"

describe Swagger::OAuth2Flow do
  describe "#new" do
    it "should works" do
      raw = Swagger::OAuth2Flow.new("authorizationCode")
      raw.name.should eq "authorizationCode"
      raw.authorization_url.should be_nil
      raw.token_url.should be_nil
      raw.refresh_url.should be_nil
      raw.scopes.should be_nil
    end

    it "throws an exception with undefined grant type" do
      expect_raises Swagger::UndefinedOAuth2GrantType do
        Swagger::OAuth2Flow.new("fake")
      end
    end
  end
end
