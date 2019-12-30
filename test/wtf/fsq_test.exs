defmodule Wtf.Results.PersisterTest do
  use Wtf.DataCase
  use ExUnit.Case, async: true

  import Mock

  alias Wtf.Fsq
  alias Wtf.Search

  describe "#call" do
    @foursquare_response {:ok,
                          [
                            %{
                              "items" => [
                                %{
                                  "referralId" => "e-1-5261511311d2d7cfe4189803-0",
                                  "venue" => %{
                                    "categories" => [
                                      %{
                                        "name" => "Hotel Bar"
                                      }
                                    ],
                                    "id" => "5261511311d2d7cfe4189803",
                                    "location" => %{
                                      "address" => "252 High Holborn",
                                      "cc" => "GB",
                                      "city" => "London",
                                      "country" => "United Kingdom",
                                      "distance" => 1158,
                                      "formattedAddress" => [
                                        "252 High Holborn",
                                        "London",
                                        "Greater London",
                                        "WC1V 7EN",
                                        "United Kingdom"
                                      ],
                                      "labeledLatLngs" => [
                                        %{
                                          "label" => "display",
                                          "lat" => 51.51781314398572,
                                          "lng" => -0.11818441766647803
                                        }
                                      ],
                                      "lat" => 51.51781314398572,
                                      "lng" => -0.11818441766647803,
                                      "postalCode" => "WC1V 7EN",
                                      "state" => "Greater London"
                                    },
                                    "name" => "Scarfes Bar"
                                  }
                                }
                              ]
                            }
                          ]}

    @valid_attrs %{lat: 120.5, lng: 120.5, name: "some name"}

    test "persisting a new venue" do
      with_mock Bees.Venue, explore: fn _, _, _, _, _, _, _, _ -> @foursquare_response end do
        {:ok, location} = Search.create_location(@valid_attrs)
        Fsq.search(location)
        location = Repo.preload(location, [:venues])

        venue = Enum.at(location.venues, 0)

        assert venue.name == "Scarfes Bar"
      end
    end
  end
end
