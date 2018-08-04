defmodule NonpandorasWeb.CategoryView do
  use NonpandorasWeb, :view

  def category_title(category) do
    Trans.Translator.translate(category, :title, :en)
  end

  def category_image_tag(%{image: image} = category) do
    img_tag(Image.url(image), alt: category_title(category))
  end
end
