defmodule NonpandorasWeb.PageView do
  use NonpandorasWeb, :view
  alias Nonpandoras.Portfolio.Page

  def html_body(%Page{body: nil}), do: ""

  def html_body(%Page{body: body}) do
    case Earmark.as_html(body) do
      {:ok, html, []} ->
        raw(html)

      _ ->
        body
    end
  end
end
