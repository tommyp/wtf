defmodule Wtf.Geo.QueryTest do
  use Wtf.DataCase
  use ExUnit.Case, async: true

  import Mock

  alias Wtf.Geo
  alias Wtf.Search.Area

  describe "#search" do
    @geonames_results %{
      "geonames" => [
        %{
          "lat" => 120.5,
          "lng" => 120.5,
          "name" => "Some name"
        }
      ]
    }

    test "creating a location" do
      with_mock Geonames, search: fn _location_name -> @geonames_results end do
        expected_area = %Area{
          lat: 120.5,
          lng: 120.5,
          name: "some name"
        }

        {:ok, %Area{} = area} = Geo.search("some name")
        assert area.lat == expected_area.lat
        assert area.lng == expected_area.lng
        assert area.name == expected_area.name
      end
    end

    test "with no matching result" do
      with_mock Geonames, search: fn _location_name -> @geonames_results end do
        assert Geo.search("some other name") == {:error, :no_geo_result}
      end
    end
  end
end
