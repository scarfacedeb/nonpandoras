defmodule NonpandorasWeb.PostView do
  use NonpandorasWeb, :view
  alias Nonpandoras.Portfolio.Post

  def post_image_tag(%{image: image, title: title} = post) do
    img_tag(Image.url({image, post}, :thumb), alt: title)
  end

  def html_body(%Post{body: nil}), do: ""

  def html_body(%Post{body: body}) do
    case Earmark.as_html(body) do
      {:ok, html, []} ->
        raw(html)

      _ ->
        body
    end
  end

  def published_at(%Post{published_at: ts}) do
    case Timex.format(ts, "{0D}/{0M}/{YYYY} {h24}:{m}") do
      {:ok, formatted} -> formatted
      _ -> ""
    end
  end

  def prev_page(%Plug.Conn{params: %{"page" => value}}) do
    case Integer.parse(value) do
      {page, ""} when page > 1 ->
        page - 1

      _ ->
        1
    end
  end

  def prev_page(_), do: 1

  def next_page(%Plug.Conn{params: %{"page" => value}}) do
    case Integer.parse(value) do
      {page, ""} when page > 0 ->
        page + 1

      _ ->
        2
    end
  end

  def next_page(_), do: 2
end
