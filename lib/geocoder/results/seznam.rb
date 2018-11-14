require 'geocoder/results/base'

module Geocoder::Result
  class Seznam < Base
    def address(format = :full)
      [
        user_data['suggestFirstRow'],
        user_data['suggestSecondRow'],
        user_data['suggestThirdRow']
      ].reject(&:blank?).join(', ')
    end

    def coordinates
      [user_data['latitude'].to_f, user_data['longitude'].to_f]
    end

    def state
      user_data['region']
    end

    def state_code
      ''
    end

    def country
      user_data['country']
    end

    def country_code
      ''
    end

    def district
      user_data['district']
    end

    def category
      @data['category']
    end

    def house_number
      user_data['houseNumber']
    end

    def city
      user_data['municipality']
    end

    def quarter
      user_data['quarter']
    end

    def region
      user_data['region']
    end

    def source_type
      user_data['source']
    end

    def street
      user_data['street']
    end

    def street_number
      user_data['streetNumber']
    end

    def ward
      user_data['ward']
    end

    def zip
      user_data['zipCode']
    end

    private

    def user_data
      @user_data ||= @data['userData']
    end
  end
end
