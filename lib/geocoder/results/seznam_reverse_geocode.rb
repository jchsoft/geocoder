require 'geocoder/results/base'

module Geocoder::Result
  class SeznamReverseGeocode < Base
    def address(format = :full)
      @data['label']
    end

    def coordinates
      @data['original_coordinates'].map(&:to_f)
    end

    def state
      find_by_source('regi').dig('name').to_s.delete_prefix('kraj').strip
    end

    def state_code
      ''
    end

    def country
      find_by_source('coun').dig('name')
    end

    def country_code
      ''
    end

    def district
      find_by_source('dist').dig('name').to_s.delete_prefix('okres').strip
    end

    def category
      ''
    end

    def house_number; end

    def city
      find_by_source('muni').dig('name')
    end

    def quarter
      find_by_source('quar').dig('name')
    end

    def region
      state
    end

    def source_type
      @data['items'].first.try(:[], 'source')
    end

    def street
      (find_by_source('addr').dig('name') ||
          find_by_source('stre').dig('name')).to_s.delete_prefix('ulice').strip
    end

    def street_number
      ''
    end

    def ward
      find_by_source('ward').dig('name').to_s.delete_prefix('část obce').strip
    end

    def zip
      ''
    end

    private

    def find_by_source(code)
      @data['item'].find { |item| item['source'] == code } || {}
    end
  end
end
