defmodule NonpandorasWeb.PageController do
  use NonpandorasWeb, :controller

  alias Nonpandoras.Portfolio

  def show(conn, %{"path" => [slug]}) do
    page = Portfolio.get_published_page(slug)

    if page do
      render(conn, "show.html", page: page)
    else
      render_404(conn)
    end
  end

  def show(conn, _params) do
    render_404(conn)
  end

  defp render_404(conn) do
    conn
    |> put_status(:not_found)
    |> put_view(NonpandorasWeb.ErrorView)
    |> render("404.html")
  end
end
