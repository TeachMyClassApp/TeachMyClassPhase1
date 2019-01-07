Devise.setup do |config|
  config.mailer_sender = 'Laura at Teach My Class <hello@teachmyclass.me>'

  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11

  config.reconfirmable = false
  config.expire_all_remember_me_on_sign_out = true
  # Range for password length.
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete

  require 'omniauth-google-oauth2'
  config.omniauth :google_oauth2, ENV['GOOGLE_SECRET_KEY'], ENV['GOOGLE_APP_ID'], {access_type: "offline", approval_prompt: ""}

  config.omniauth :facebook, ENV['FACEBOOK_SECRET_KEY'], ENV['FACEBOOK_APP_ID'], scope: 'email', info_fields: 'email, name'
  config.omniauth :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']
end 

