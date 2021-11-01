# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    redirect_to "/resetbyforgotpassword?token=#{params[:reset_password_token]}"
  end
end
