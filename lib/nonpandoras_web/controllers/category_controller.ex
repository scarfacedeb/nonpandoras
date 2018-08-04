defmodule NonpandorasWeb.CategoryController do
  use NonpandorasWeb, :controller

  alias Nonpandoras.Portfolio
  alias Nonpandoras.Portfolio.Category

  def show(conn, %{"id" => slug} = params) do
    category = Portfolio.get_category!(slug)
    artworks = Portfolio.list_artworks_in_category(category, params)

    render(conn, "show.html", category: category, artworks: artworks)
  end
end
