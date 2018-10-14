defmodule NonpandorasWeb.Admin.PostView do
  use NonpandorasWeb, :view
  import NonpandorasWeb.Admin.FormHelpers

  def post_image_tag(%{image: nil}), do: nil

  def post_image_tag(post) do
    img_tag(Image.url({post.image, post}, :thumb), alt: post.title)
  end
end
