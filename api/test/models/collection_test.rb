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

  test 'Can add an existing release to a collection' do
    collection = collections(:bpmbox)
    oh_mercy = releases(:oh_mercy)
    collection.releases << oh_mercy
    collection.reload
    assert collection.releases.last.title == oh_mercy.title
    assert collection.releases.last.persisted?
  end

  test 'Can add a new release to a collection' do
    collection = collections(:bpmbox)
    new_release = Release.new(title: 'Title', artist: 'Artist')
    collection.releases << new_release
    collection.reload
    assert collection.releases.last.title == 'Title'
    assert collection.releases.last.persisted?
  end

  test 'Gracefully fails when adding a duplicate release' do
    collection = collections(:bpmbox)
    collection.releases << releases(:oh_mercy)
    collection.save
    collection.releases << releases(:oh_mercy)
  end
end
