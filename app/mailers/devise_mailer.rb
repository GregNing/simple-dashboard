class DeviseMailer < ApplicationMailer
  include ::Devise::Mailers::Helpers
  include ::Devise::Controllers::UrlHelpers
  include ::Rails.application.routes.url_helpers

  default from: '自慢塾會員系統 <no-reply@techbang.com.tw>'

  def reset_password_instructions(record, token, opts: {})
    @token = token
    @namespace = record.class.namespace
    # @edit_password_url = edit_password_url(record, reset_password_token: @token, namespace: @namespace)
    @edit_password_url = root_url.concat("#{@namespace}/reset_password?token=#{@token}") # defined in react routes
    devise_mail(record, :reset_password_instructions, opts)
  end
end
