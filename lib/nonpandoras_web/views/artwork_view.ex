defmodule NonpandorasWeb.ArtworkView do
  use NonpandorasWeb, :view
  alias Nonpandoras.Portfolio.Artwork

  def artwork_image_tag(artwork) do
    img_tag(Image.url({artwork.image, artwork}), alt: artwork.title)
  end

  def html_body(%Artwork{description: nil}), do: ""

  def html_body(%Artwork{description: md}) do
    case Earmark.as_html(md) do
      {:ok, html, []} ->
        raw(html)

      _ ->
        md
    end
  end
end
