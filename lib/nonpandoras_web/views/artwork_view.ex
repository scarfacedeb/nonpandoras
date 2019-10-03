defmodule NonpandorasWeb.ArtworkView do
  use NonpandorasWeb, :view
  alias Nonpandoras.Portfolio.Artwork

  def artwork_tile_image_tag(artwork) do
    src = Image.url({artwork.image, artwork}, :tile_1)
    srcset =
      Image.tiles()
      |> Enum.map(fn {density, ver} ->
        url = Image.url({artwork.image, artwork}, ver)
        "#{url} #{density}x"
      end)
      |> Enum.join(", ")

    img_tag(src, alt: artwork.title, srcset: srcset)
  end

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
