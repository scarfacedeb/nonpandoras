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
end
