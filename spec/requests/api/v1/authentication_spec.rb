require "rails_helper"

RSpec.describe Api::V1::AuthenticationsController, :type => :request do

  let!(:user) { FactoryGirl.create(:user) }

  context "authenticate" do
    it "should return the user information with the a valid auth token" do
      user
      credentials = {username: user.username, password: user.password}

      post "/api/v1/authenticate", credentials
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body)
      expect(response_body["data"].keys).to eq(["id", "name", "username", "auth_token", "token_created_at", "sign_in_count", "current_sign_in_at", "last_sign_in_at"])
      expect(response_body["message"]).to eq("You have successfully authenticated")
    end
    
    it "should return error for invalid username" do
      user
      credentials = {username: "invalid username", password: user.password}

      post "/api/v1/authenticate", credentials
      response_body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(response_body["message"]).to eq("Invalid Login Attempt")
      expect(response_body["error"]["base"]).to eq("Invalid username or password")
    end

    it "should return error for invalid password" do
      user
      credentials = {username: user.username, password: "invalid password"}

      post "/api/v1/authenticate", credentials
      response_body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(response_body["message"]).to eq("Invalid Login Attempt")
      expect(response_body["error"]["base"]).to eq("Invalid username or password")
    end
  end
  
end