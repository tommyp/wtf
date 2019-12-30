defmodule Wtf.Geo do
  alias Wtf.Search
  alias Wtf.Repo

  def search(area_name) do
    case Geonames.search(%{q: area_name}) do
      %{"geonames" => results} ->
        geo_result = results |> Enum.find(fn l -> String.downcase(l["name"]) == area_name end)

        if geo_result do
          {:ok, area} =
            Search.create_area(%{
              name: String.downcase(geo_result["name"]),
              lat: geo_result["lat"],
              lng: geo_result["lng"]
            })

          area = Repo.preload(area, [:venues])

          {:ok, area}
        else
          # query doesn't match result
          {:error, :no_geo_result}
        end

      _ ->
        # no Geonames result
        {:error, :no_geo_result}
    end
  end
end
