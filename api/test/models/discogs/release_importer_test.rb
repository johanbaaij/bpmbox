# frozen_string_literal: true

require 'test_helper'
module Discogs
  class ReleaseImporterTest < ActiveSupport::TestCase
    setup do
      @user = users(:no_discogs)
      @user_connected_to_discogs = users(:authorized_discogs)
    end

    test 'Running the importer adds releases to database' do
      importer = Discogs::ReleaseImporter.new(@user_connected_to_discogs)
      importer.import
      assert_not_empty @user_connected_to_discogs.releases
      assert @user_connected_to_discogs.releases.first.persisted?
    end

  end
end
