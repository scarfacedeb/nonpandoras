defmodule NonpandorasWeb.Admin.ArtworkView do
  use NonpandorasWeb, :view
  import NonpandorasWeb.Admin.FormHelpers

  def artwork_image_tag(%{image: nil}), do: nil

  def artwork_image_tag(%{image: image} = artwork) do
    img_tag(Image.url({artwork.image, artwork}, :thumb), alt: translate(artwork, :title, :en))
  end

  defdelegate category_options(), to: Nonpandoras.Admin
end