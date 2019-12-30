defmodule Wtf.Fsq do
  alias Wtf.Search
  alias Wtf.Repo

  def search(area) do
    case foursquare_results(area.lat, area.lng) do
      {:ok, response} ->
        response
        # wtf is this an array with 1 thing in it?
        |> Enum.at(0)
        |> Map.get("items")
        |> Enum.map(fn venue_hash -> create_venue(venue_hash, area) end)

        area
        |> Search.update_area(%{refreshed_at: Timex.now()})

      {:error, _} ->
        nil
    end
  end

  defp create_venue(venue_hash, area) do
    venue_data = Map.get(venue_hash, "venue")

    venue = Search.get_venue_by_source_id!(venue_data["id"])

    if venue == nil do
      [category | _] = venue_data["categories"]

      IO.puts(venue_data["name"])

      {:ok, venue} =
        Search.create_venue(%{
          category: category["name"],
          name: venue_data["name"],
          source_url: venue_data["url"],
          area_id: area.id,
          source_id: venue_data["id"]
        })
    end

    venue
  end

  defp foursquare_results(lat, lng, n \\ 100) do
    Bees.Venue.explore(
      bees_client(),
      lat,
      lng,
      n,
      "topPicks",
      0,
      0,
      3000
    )
  end

  defp bees_client() do
    %Bees.Client{
      client_id: Application.get_env(:bees, :foursquare_client_id),
      client_secret: Application.get_env(:bees, :foursquare_client_secret),
      access_token: nil
    }
  end
end
