defmodule NonpandorasWeb.Admin.CategoryView do
  use NonpandorasWeb, :view
  import NonpandorasWeb.Admin.FormHelpers

  def category_image_tag(%{image: nil}), do: nil

  def category_image_tag(category) do
    img_tag(Image.url({category.image, category}, :thumb), alt: category.title)
  end
end
