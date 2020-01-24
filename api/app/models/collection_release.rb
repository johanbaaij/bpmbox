class CollectionRelease < ActiveRecord::Base
  self.table_name = "collections_releases"
  belongs_to :collection
  belongs_to :release
end