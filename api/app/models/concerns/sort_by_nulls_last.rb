# frozen_string_literal: true

require 'active_support/concern'

module SortByNullsLast
  extend ActiveSupport::Concern

  class_methods do
    DIRS = %i[asc desc].freeze

    def sort_by_nulls_last(*attributes)
      attributes.each do |attribute|
        DIRS.each do |dir|
          scope "sort_by_#{attribute}_nulls_last_#{dir}".to_sym,
                -> { order("#{attribute} #{dir.upcase} NULLS LAST") }
        end
      end
    end
  end
end
