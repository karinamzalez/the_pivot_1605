Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "ahGLntvviL5GRSY2E6JIPFv0V", "33nnrm24oa2jRwJoVNqoGlVw9fUzhnX9YfznasTqlciFTSw87d"
end

# "ahGLntvviL5GRSY2E6JIPFv0V"
# "33nnrm24oa2jRwJoVNqoGlVw9fUzhnX9YfznasTqlciFTSw87d"
#   
#   
# ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'