require 'geocoder/lookups/base'
require 'geocoder/results/seznam'
require 'geocoder/results/seznam_reverse_geocode'
require 'active_support/core_ext'

module Geocoder::Lookup
  class Seznam < Base
    def name
      'Seznam'
    end

    private # ---------------------------------------------------------------

    def base_query_url(query)
      return "#{protocol}://api.mapy.cz/rgeocode?" if Thread.current["reverse_geocoded"]

      "#{protocol}://api.mapy.cz/suggest/?"
    end

    def parse_raw_data(raw_data)
      Geocoder.log(:debug, "searching: #{Thread.current["query"].text}, response: #{raw_data.inspect}, reverse: #{Thread.current["reverse_geocoded"]}")
      return Hash.from_xml(raw_data) if Thread.current["reverse_geocoded"]

      super
    end

    def results(query, _reverse = false)
      Thread.current["query"] = query
      Thread.current["reverse_geocoded"] = query.reverse_geocode?
      doc = fetch_data(query)
      return [] unless doc
      return Array.wrap(doc.dig('result')) unless Thread.current["reverse_geocoded"]

      Array.wrap(doc.dig('rgeocode')).map do |res|
        res['original_coordinates'] = query.coordinates
        res
      end
    end

    def query_url_params(query)
      params = { phrase: query.sanitized_text, count: 5 } unless Thread.current["reverse_geocoded"]
      params ||= { lat: query.coordinates[0],
                   lon: query.coordinates[1] }
      params.merge(super)
    end

    def result_class
      return Geocoder::Result::SeznamReverseGeocode if Thread.current["reverse_geocoded"]

      super
    end
  end
end
