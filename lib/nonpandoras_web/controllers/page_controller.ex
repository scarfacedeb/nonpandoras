defmodule NonpandorasWeb.PageController do
  use NonpandorasWeb, :controller

  alias Nonpandoras.Portfolio

  def show(conn, %{"id" => slug}) do
    page = Portfolio.get_page!(slug)
    render(conn, "show.html", page: page)
  end
end
