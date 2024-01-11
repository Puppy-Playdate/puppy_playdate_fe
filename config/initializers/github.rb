Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'aae04c62b896b4d08290', '151b9d3f3f3ef1ada314ba57422e7f753e0b7829'
end