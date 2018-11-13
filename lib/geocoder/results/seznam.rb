require 'geocoder/results/base'

module Geocoder::Result
  class Seznam < Base
    def address
      @data['title']
    end

    def coordinates
      [@data['x'].to_f, @data['y'].to_f]
    end

    def state; end

    def state_code; end

    def country; end

    def country_code; end

    def exact_location?
      @data['source'] == 'addr' && @data['type'] == 'addr'
    end
  end
end
