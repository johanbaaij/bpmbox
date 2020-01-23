# frozen_string_literal: true

require 'test_helper'

class CollectionTest < ActiveSupport::TestCase
  test 'Collection with incorrect username is invalid' do
    @collection = Collection.new(username: 'incorrect_incorrect_incorrect')
    assert_not @collection.valid?
  end

  test 'Collection with correct username is valid' do
    @collection = Collection.new(username: 'johanbaaij')
    assert @collection.valid?
  end
end
