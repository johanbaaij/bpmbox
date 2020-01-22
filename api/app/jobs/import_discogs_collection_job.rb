class ImportDiscogsCollectionJob < ApplicationJob
  queue_as :default

  def perform(username)
    importer = Discogs::CollectionImporter.new(username)
    importer.import
  end
end
