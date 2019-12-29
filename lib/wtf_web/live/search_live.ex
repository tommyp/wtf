defmodule WtfWeb.SearchLive do
  use Phoenix.LiveView

  def render(assigns) do
    WtfWeb.SearchView.render("search.html", assigns)
  end

  def handle_event("handle_search", %{"query" => query}, socket) do
    IO.puts(query)

    case Wtf.Geo.search(query) do
      {:ok, area} ->
        {:noreply, assign(socket, :query, area.name)}

      {:error, :no_geo_result} ->
        {:noreply, assign(socket, :query, "no result")}
    end
  end

  def mount(%{"query" => query}, socket) do
    {:ok, assign(socket, :query, query)}
  end
end
