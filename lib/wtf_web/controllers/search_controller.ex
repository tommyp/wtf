defmodule WtfWeb.SearchController do
  use WtfWeb, :controller
  alias Phoenix.LiveView

  def index(conn, _params) do
    LiveView.Controller.live_render(conn, WtfWeb.SearchLive, session: %{})
  end
end
