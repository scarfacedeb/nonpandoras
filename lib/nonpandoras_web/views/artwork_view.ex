defmodule NonpandorasWeb.ArtworkView do
  use NonpandorasWeb, :view

  def artwork_image_tag(artwork) do
    img_tag(Image.url({artwork.image, artwork}), alt: artwork.title)
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
