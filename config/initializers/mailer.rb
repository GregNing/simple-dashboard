# frozen_string_literal: true

ActionMailer::Base.smtp_settings = {
  port:      587,
  address:   ENV['SMTP_SERVER'],
  user_name: ENV['SMTP_LOGIN'],
  password:  ENV['SMTP_PASSWORD'],
  domain: ENV['SMTP_DOMAIN'],
  authentication: 'plain'
}
