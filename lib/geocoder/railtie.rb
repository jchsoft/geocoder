require 'geocoder'

module Geocoder
  if defined? Rails::Railtie
    require 'rails'
    class Railtie < Rails::Railtie
      initializer 'geocoder.insert_into_active_record' do
        ActiveSupport.on_load :active_record do
          Geocoder::Railtie.insert
        end
      end
      rake_tasks do
        load "tasks/geocoder.rake"
      end
    end
  end

  class Railtie
    def self.insert
      return unless defined?(::ActiveRecord)
      ::ActiveRecord::Base.extend(ModelMethods)
    end
  end

  ##
  # Methods available in the model class before Geocoder is invoked.
  #
  module ModelMethods

    ##
    # Set attribute names and include the Geocoder module.
    #
    def geocoded_by(address_attr, options = {}, &block)
      geocoder_init(
        :user_address => address_attr,
        :latitude  => options[:latitude]  || :latitude,
        :longitude => options[:longitude] || :longitude,
        :block => block
      )
    end

    ##
    # Set attribute names and include the Geocoder module.
    #
    def reverse_geocoded_by(latitude_attr, longitude_attr, options = {})
      geocoder_init(
        :fetched_address => options[:address] || :address,
        :latitude  => latitude_attr,
        :longitude => longitude_attr
      )
    end

    def geocoder_options
      @geocoder_options
    end


    private # ----------------------------------------------------------------

    def geocoder_init(options)
      unless geocoder_initialized?
        @geocoder_options = options
        require 'geocoder/orms/active_record'
        include Geocoder::Orm::ActiveRecord
      end
    end

    def geocoder_initialized?
      begin
        included_modules.include? Geocoder::Orm::ActiveRecord
      rescue NameError
        false
      end
    end
  end
end