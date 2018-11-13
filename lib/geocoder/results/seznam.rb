require 'geocoder/results/base'

module Geocoder::Result
  class Seznam < Base

    def coordinates
      [@data["x"].to_f, @data["y"].to_f]
    end

    def address
      @data["label"]
    end

    def state
      @data["label"]
    end

    def province
      @data["label"]
    end

    def city
      @data["label"]
    end

    def district
      @data["label"]
    end

    def street
      @data["label"]
    end

    def street_number
      @data["label"]
    end

    def formatted_address
      @data["label"]
    end

    def address_components
      @data["label"]
    end

    def state_code
      @data["label"]
    end

    def postal_code
      @data["label"]
    end

    def country
      @data["label"]
    end

    def country_code
      @data["CZ"]
    end

    def self.response_attributes
      []
    end
  end
end
