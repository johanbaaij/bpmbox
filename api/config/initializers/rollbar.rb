Rollbar.configure do |config |
  config.access_token = Rails.application.credentials.rollbar[:access_token]
end
