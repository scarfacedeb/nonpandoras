defmodule NonpandorasWeb.ArtworkController do
  use NonpandorasWeb, :controller

  alias Nonpandoras.Portfolio
  alias Nonpandoras.Portfolio.Artwork

  def show(conn, %{"id" => slug}) do
    artwork = Portfolio.get_artwork!(slug)
    prev_artwork = Portfolio.get_prev(artwork)
    next_artwork = Portfolio.get_next(artwork)

    render(conn, "show.html",
      artwork: artwork,
      prev_artwork: prev_artwork,
      next_artwork: next_artwork
    )
  end
end
