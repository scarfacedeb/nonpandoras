defmodule NonpandorasWeb.Admin.ArtworkView do
  use NonpandorasWeb, :view
  import NonpandorasWeb.Admin.FormHelpers
  import NonpandorasWeb.Pagination

  def artwork_image_tag(%{image: nil}), do: nil

  def artwork_image_tag(artwork) do
    img_tag(Image.url({artwork.image, artwork}, :thumb), alt: artwork.title)
  end

  defdelegate category_options(), to: Nonpandoras.Admin.Artworks
end
