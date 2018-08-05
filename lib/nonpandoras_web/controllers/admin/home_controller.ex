defmodule NonpandorasWeb.Admin.HomeController do
  use NonpandorasWeb, :controller

  plug :put_layout, {NonpandorasWeb.LayoutView, "admin.html"}

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
