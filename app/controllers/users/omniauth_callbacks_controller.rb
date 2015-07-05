class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  #before_action :set_user

  def facebook
    credential.update!(auth_hash: auth)

    if credential.user.persisted?
      sign_in_and_redirect credential.user, event: :authentication
      set_flash_message(:notice, :success, kind: :facebook) if is_navigational_format?
    else
      session["devise.oauth_data"] = auth
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(auth)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = auth
      redirect_to new_user_registration_url
    end
  end


  def google
    credential.update!(auth_hash: auth)

    if credential.user.persisted?
      sign_in_and_redirect credential.user, event: :authentication
      set_flash_message(:notice, :success, kind: :google) if is_navigational_format?
    else
      redirect_to new_user_registration_url
    end
  end

  private

  def auth
    @auth ||= request.env["omniauth.auth"]
  end


end