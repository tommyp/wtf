defmodule WtfWeb.SearchLive do
  use Phoenix.LiveView

  def render(assigns) do
    WtfWeb.SearchView.render("search.html", assigns)
  end

  def handle_event("handle_search", %{"query" => query}, socket) do
    IO.puts(query)

    {:noreply, assign(socket, :query, query)}
  end

  def mount(%{query: query}, socket) do
    {:ok, assign(socket, :query, query)}
  end
end
