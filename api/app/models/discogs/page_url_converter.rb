# frozen_string_literal: true

module Discogs
  class PageUrlConverter
    def initialize(url)
      @url = url
    end

    def to_api_url
      case resource_type
      when 'release'
        "/#{resource_type}/#{resource_id}"
      else
        raise 'Could not infer type'
      end
    end

    def resource_type
      'release' if segments[-2] == 'release'
    end

    def resource_id
      segments.last
    end

    protected

    def segments
      URI(@url).path.split('/')
    end
  end
end
