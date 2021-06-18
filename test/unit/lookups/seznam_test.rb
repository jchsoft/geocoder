# encoding: utf-8
require 'test_helper'
require 'minitest'

class SeznamTest < GeocoderTestCase

  def setup
    Geocoder.configure(lookup: :seznam)
    set_api_key!(:seznam)
  end

  def test_result_components
    result = Geocoder.search("Madison Square Garden, New York, NY").first
    assert_equal "Madison Square Garden, obec Manhattan Community Board 5, Spojené státy americké", result.address
  end

  def test_reverse_geocode
    result = Geocoder.search([40.750518548570199, -73.993494158744895]).first
    assert_equal "Hlaváčova 207, Pardubice, 530 02, Pardubice", result.address
  end
end
