defmodule WtfWeb.SearchLive do
  use Phoenix.LiveView

  alias Wtf.Search
  alias Wtf.Search.Area
  alias Wtf.Repo

  def render(assigns) do
    WtfWeb.SearchView.render("search.html", assigns)
  end

  def handle_event("handle_search", %{"query" => query}, socket) do
    area_name = query |> geo_query_param

    case find_or_create_area(area_name) do
      {:ok, area} ->
        cond do
          Enum.empty?(area.venues) ->
            fetch_results_for_area(area)

          Timex.before?(area.refreshed_at, Timex.today()) ->
            fetch_results_for_area(area)

          true ->
            area
        end

        area = Repo.preload(area, [:venues], force: true)

        cond do
          Enum.empty?(area.venues) ->
            {:noreply, assign(socket, :query, "there's nothing to fucking do here")}

          true ->
            {:noreply, assign(socket, :query, area.name)}
        end
    end
  end

  def mount(%{"query" => query}, socket) do
    {:ok, assign(socket, :query, query)}
  end

  defp find_or_create_area(area_name) do
    area = area_name |> Search.get_area_by_name!()

    if area do
      area = Repo.preload(area, [:venues])
      {:ok, area}
    else
      area_name
      |> Wtf.Geo.search()
    end
  end

  defp fetch_results_for_area(%Area{} = area) do
    Wtf.Fsq.search(area)
  end

  defp geo_query_param(query) do
    query
    |> String.replace("%20", " ")
    |> String.downcase()
  end
end
