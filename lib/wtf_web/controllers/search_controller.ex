defmodule WtfWeb.SearchController do
  use WtfWeb, :controller
  alias Phoenix.LiveView

  def index(conn, params) do
    LiveView.Controller.live_render(conn, WtfWeb.SearchLive, session: %{"query" => params["query"]})
  end
end
