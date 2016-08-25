Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["twitter_app_key"], ENV["twitter_app_secret"]
end