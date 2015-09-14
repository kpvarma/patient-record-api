module Api
  module V1
    class AuthenticationsController < ApplicationController

      def authenticate
        @user = User.find_by_username(params[:username])
        if @user
          if @user.authenticate(params[:password])
            render json: { data: @user, message: "You have successfully authenticated" }
          else
            render_invalid_json
          end
        else
          render_invalid_json
        end
      end

      private

      def render_invalid_json
        render json: { error: {base: "Invalid username or password"}, message: "Invalid Login Attempt" }
      end
      
    end
  end
end
