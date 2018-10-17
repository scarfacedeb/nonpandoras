defmodule NonpandorasWeb.Router do
  use NonpandorasWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/admin", NonpandorasWeb.Admin, as: :admin do
    pipe_through :browser

    get "/", HomeController, :index

    resources "/artworks", ArtworkController
    resources "/categories", CategoryController
    resources "/posts", PostController
    resources "/pages", PageController
  end

  scope "/", NonpandorasWeb do
    pipe_through :browser

    get "/", HomeController, :index

    resources "/categories", CategoryController, only: [:show]
    resources "/artworks", ArtworkController, only: [:show]
    resources "/posts", PostController, only: [:index, :show]

    get "/*path", PageController, :show
  end
end
