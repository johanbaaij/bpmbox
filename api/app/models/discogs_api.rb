class DiscogsApi
  delegate :get_identity, to: :@discogs

  def initialize(user)
    @user = user
    @discogs = Discogs::Wrapper.new('bpmbox', access_token)
  end

  def authenticated?
    @discogs.get_identity
    @discogs.authenticated?
  rescue
    false
  end

  def get_request_data
    @request_data = @discogs.get_request_token(
      Rails.application.credentials.discogs[:key],
      Rails.application.credentials.discogs[:secret],
      "#{Rails.configuration.settings['client_url']}/discogs/callback"
    )
    store_request_token_temporarily
    @request_data
  end

  def get_access_token(verifier)
    access_token = @discogs.authenticate(request_token, verifier)
    @user.update(
      discogs_request_token: nil,
      discogs_access_token: access_token.params
    )
  end

  protected

  def request_token
    OAuth::RequestToken.from_hash(
      consumer,
      @user.discogs_request_token.symbolize_keys
    )
  end

  def access_token
    if @user.discogs_access_token.present?
      OAuth::AccessToken.from_hash(
        consumer,
        @user.discogs_access_token.symbolize_keys
      )
    end
  end

  def consumer
    OAuth::Consumer.new(
      Rails.application.credentials.discogs[:key],
      Rails.application.credentials.discogs[:secret],
      site: "https://api.discogs.com"
    )
  end

  def store_request_token_temporarily
    @user.update(
      discogs_request_token: @request_data[:request_token].params
    )
  end
end