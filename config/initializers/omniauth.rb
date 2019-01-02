Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_SECRET_KEY'], ENV['GOOGLE_APP_ID'], {access_type: "offline", approval_prompt: ""}
end