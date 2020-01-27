Rollbar.configure do |config |
  config.access_token = Rails.application.credentials.rollbar[:access_token]
  config.enabled = false unless Rails.env.production?
end
