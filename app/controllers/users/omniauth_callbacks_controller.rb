class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
    def facebook
        @user = UserProvider.find_for_facebook_oauth(request.env["omniauth.auth"])

        if @user.persisted?
          sign_in_and_redirect @user, :event => :authentication               
        else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
    end

    def twitter
        auth = env["omniauth.auth"]
        puts auth
        @user = UserProvider.find_for_twitter_oauth(request.env["omniauth.auth"])
        flash[:notice] = "Signed in with TTTwitter successfully."
        if @user.persisted?         
          sign_in_and_redirect @user, :event => :authentication
        else
          flash[:notice] = "Signed in with Twitter UNsuccessfully."
          session["devise.twitter_uid"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
    end




end