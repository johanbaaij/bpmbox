# frozen_string_literal: true

require 'test_helper'
module Discogs
  class CollectionImporterTest < ActiveSupport::TestCase
    setup do
      @collection = collections(:johanbaaij)
    end

    test 'CollectionImporter with non existent Discogs user is invalid' do
      importer = Discogs::CollectionImporter.new("incorrect_incorrect_incorrect")
      assert_not importer.valid?
    end

    test 'CollectionImporter with existent Discogs user is valid' do
      importer = Discogs::CollectionImporter.new("johanbaaij")
      assert importer.valid?
    end

    test 'CollectionImporter adds releases to database' do
      importer = Discogs::CollectionImporter.new("johanbaaij")
      importer.import
      # assert @collection.releases.count == 235
      assert @collection.releases.last.persisted?
    end

  end
end
