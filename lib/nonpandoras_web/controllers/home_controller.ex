defmodule NonpandorasWeb.HomeController do
  use NonpandorasWeb, :controller

  alias Nonpandoras.Portfolio

  def index(conn, _params) do
    greeting = Portfolio.get_greeting()
    artworks = Portfolio.list_last_artworks()
    posts = Portfolio.Posts.list_last_posts()

    render(conn, "index.html", artworks: artworks, posts: posts, greeting: greeting)
  end
end
