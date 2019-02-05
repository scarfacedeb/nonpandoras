defmodule NonpandorasWeb.LayoutView do
  use NonpandorasWeb, :view

  def render_ga do
    if Nonpandoras.Application.env() == :prod do
      render __MODULE__, "_ga.html", []
    end
  end

  def sidebar_categories do
    Nonpandoras.Portfolio.list_published_categories()
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
