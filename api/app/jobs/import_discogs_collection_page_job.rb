class ImportDiscogsCollectionPageJob
  include Sidekiq::Worker
  include Sidekiq::Throttled::Worker
  sidekiq_options queue: :discogs

  sidekiq_throttle(
    concurrency: { limit: 1 },
    threshold: { limit: 1, period: 3.seconds }
  )

  def perform(url, username)

    @username = username
    @collection = Collection.find_or_initialize_by(username: username)

    fetch_and_add_releases(url)
  end

  def fetch_and_add_releases(url)
    response = Discogs::Api.new.raw(url)
    @collection.add_releases_from_api(response.releases)
    @collection.save
    handle_next_page(response)
  end

  def handle_next_page(response)
    return unless response.pagination.urls.next

    ImportDiscogsCollectionPageJob.perform(response.pagination.urls.next, @username)
  end
end
