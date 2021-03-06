defmodule WtfWeb.Router do
  use WtfWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WtfWeb do
    pipe_through :browser

    get "/", SearchController, :index
    get "/:query", SearchController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", WtfWeb do
  #   pipe_through :api
  # end
end
