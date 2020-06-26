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
      source_value('regi').to_s.delete_prefix('kraj').strip
    end

    def state_code
      ''
    end

    def country
      source_value('coun') || source_value('osmc')
    end

    def country_code
      ''
    end

    def district
      (source_value('dist') || source_value('osmr')).to_s.delete_prefix('okres').strip
    end

    def category
      ''
    end

    def house_number; end

    def city
      source_value('muni') || source_value('osmm')
    end

    def quarter
      source_value('quar')
    end

    def region
      state
    end

    def source_type
      location_data.first.try(:[], 'source')
    end

    def street
      (source_value('addr') || source_value('stre') || source_value('osms')).to_s.delete_prefix('ulice').strip
    end

    def street_number
      ''
    end

    def ward
      (source_value('ward') || source_value('osmw')).to_s.delete_prefix('část obce').strip
    end

    def postal_code
      ''
    end

    private

    def source_value(code)
      find_by_source(code).dig('name')
    end

    def find_by_source(code)
      location_data.find { |item| item['source'] == code } || {}
    end

    def location_data
      Array.wrap(@data['item'])
    end
  end
end
