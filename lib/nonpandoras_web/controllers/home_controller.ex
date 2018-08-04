defmodule NonpandorasWeb.HomeController do
  use NonpandorasWeb, :controller

  alias Nonpandoras.Portfolio

  def index(conn, _params) do
    categories = Portfolio.get_categories()
    render(conn, "index.html", categories: categories)
  end
end
