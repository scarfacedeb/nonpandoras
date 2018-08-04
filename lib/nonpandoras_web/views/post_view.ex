defmodule NonpandorasWeb.PostView do
  use NonpandorasWeb, :view

  def post_image_tag(%{image: image} = post) do
    img_tag(
      Image.url("Image-000#{Enum.random([1,2,3,4,5,6])}.png?63677739391"),
      alt: translate(post, :title, :en),
      width: "300px"
    )
  end

  def post_summary(post) do
    case translate(post, :summary, :en) do
      "" ->
        # summary_from_body(post)
        ""

      summary ->
        summary
    end
  end

  defp summary_from_body(post) do
    post
    |> translate(:body, :en)
    |> Floki.find("p")
    |> List.first()
    |> raw_html()
  end

  defp raw_html(nil), do: ""

  defp raw_html(paragraph) do
    paragraph
    |> Floki.raw_html()
    |> raw()
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
