defmodule NonpandorasWeb.PostController do
  use NonpandorasWeb, :controller

  alias Nonpandoras.Portfolio

  def index(conn, params) do
    posts = Portfolio.Posts.list_posts(params)
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => slug}) do
    post = Portfolio.Posts.get_published_post!(slug)
    prev_post = nil
    next_post = nil

    render(conn, "show.html",
      post: post,
      prev_post: prev_post,
      next_post: next_post
    )
  end
end
