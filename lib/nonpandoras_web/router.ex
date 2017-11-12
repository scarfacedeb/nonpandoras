defmodule NonpandorasWeb.Router do
  use NonpandorasWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", NonpandorasWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # scope "/admin", NonpandorasWeb.Admin do
  #   pipe_through :browser
  # end
end
