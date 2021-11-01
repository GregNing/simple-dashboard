# frozen_string_literal: true

ActionMailer::Base.smtp_settings = {
  address: 'smtp.mailgun.org',
  port: 587,
  domain: 'herokuapp.com',
  user_name: ENV['SMTP_USER'],
  password: ENV['SMTP_PASSWORD'],
  authentication: :login,
  enable_starttls_auto: true
}
