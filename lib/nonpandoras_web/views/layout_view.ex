defmodule NonpandorasWeb.LayoutView do
  use NonpandorasWeb, :view

  def sidebar_categories do
    Nonpandoras.Portfolio.get_categories()
  end

  def sidebar_pages do
    Nonpandoras.Portfolio.list_sidebar_pages()
  end

  def nav_link(%Plug.Conn{path_info: path_info}, text, path) do
    nav_link(path_info, text, path)
  end

  def nav_link(["categories", current | _], text, "/categories/" <> slug = path) when current == slug do
    li(:current, text, path)
  end

  def nav_link(["posts" | _], text, "/posts" <> _ = path) do
    li(:current, text, path)
  end

  def nav_link([current | _], text, "/" <> slug = path) when current == slug do
    li(:current, text, path)
  end

  def nav_link(_path_info, text, path) do
    li(text, path)
  end

  defp li(:current, text, path) do
    content_tag :li, class: "nav__link nav__link--current" do
      link(text, to: path)
    end
  end

  defp li(text, path) do
    content_tag :li, class: "nav__link" do
      link(text, to: path)
    end
  end
end
