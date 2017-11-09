defmodule NonpandorasWeb.PageController do
  use NonpandorasWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
