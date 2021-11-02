# frozen_string_literal: true

ActionMailer::Base.smtp_settings = {
  port:      587,
  address:   ENV['MAILGUN_SMTP_SERVER'],
  user_name: ENV['MAILGUN_SMTP_LOGIN'],
  password:  ENV['MAILGUN_SMTP_PASSWORD'],
  domain: ENV['MAILGUN_DOMAIN'],
  authentication: 'plain',
  enable_starttls_auto: true
}
