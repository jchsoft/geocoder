require 'geocoder/lookups/base'
require 'geocoder/results/seznam'
require 'active_support/core_ext'

module Geocoder::Lookup
  class Seznam < Base

    def name
      "Seznam"
    end

    private # ---------------------------------------------------------------

    def base_query_url(query)
      path = query.reverse_geocode? ? 'rgeocode' : 'geocode'
      "#{protocol}://api.mapy.cz/#{path}?"
    end

    def parse_raw_data(raw_data)
      Hash.from_xml(raw_data)
    end

    def results(query, reverse = false)
      doc = fetch_data(query)
      return [] unless doc
      # TODO upravit klic taky na normal geocode a ne jen rgeocode
      search_result = Array.wrap(doc.dig("rgeocode", "item"))
      search_result.map { |res| res["label"] = doc["label"] }
    end

    def query_url_params(query)
      params = {query: query.sanitized_text} unless query.reverse_geocode?
      # http://api.mapy.cz/rgeocode?lon=14.393524&lat=50.124239
      params ||= { lon: query.coordinates[0],
                   lat: query.coordinates[1] }
      params.merge(super)
    end
  end
end
