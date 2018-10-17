defmodule NonpandorasWeb.CategoryView do
  use NonpandorasWeb, :view
  import NonpandorasWeb.Pagination

  def category_image_tag(%{image: image} = category) do
    img_tag(Image.url(image), alt: category.title)
  end
end
