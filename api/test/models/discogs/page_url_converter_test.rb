# frozen_string_literal: true

require 'test_helper'
module Discogs
  class PageUrlConverterTest < ActiveSupport::TestCase
    test 'Detects release type' do
      url = 'https://www.discogs.com/Gregory-Isaacs-Out-Deh/release/14661452'
      converter = Discogs::PageUrlConverter.new(url)
      assert converter.resource_type == 'release'
    end
  end
end
