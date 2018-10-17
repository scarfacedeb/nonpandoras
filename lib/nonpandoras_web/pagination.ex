defmodule NonpandorasWeb.Pagination do
  import Scrivener.HTML

  def render_pagination(page) do
    pagination_links(page, distance: 1, next: "Next", previous: "Previous")
  end
end
