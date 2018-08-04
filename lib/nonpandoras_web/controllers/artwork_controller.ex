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

  #   def new(conn, _params) do
  #     changeset = Portfolio.change_artwork(%Artwork{})
  #     render(conn, "new.html", changeset: changeset)
  #   end

  #   def create(conn, %{"artwork" => artwork_params}) do
  #     case Portfolio.create_artwork(artwork_params) do
  #       {:ok, artwork} ->
  #         conn
  #         |> put_flash(:info, "Artwork created successfully.")
  #         |> redirect(to: artwork_path(conn, :show, artwork))
  #       {:error, %Ecto.Changeset{} = changeset} ->
  #         render(conn, "new.html", changeset: changeset)
  #     end
  #   end

  #   def edit(conn, %{"id" => id}) do
  #     artwork = Portfolio.get_artwork!(id)
  #     changeset = Portfolio.change_artwork(artwork)
  #     render(conn, "edit.html", artwork: artwork, changeset: changeset)
  #   end

  #   def update(conn, %{"id" => id, "artwork" => artwork_params}) do
  #     artwork = Portfolio.get_artwork!(id)

  #     case Portfolio.update_artwork(artwork, artwork_params) do
  #       {:ok, artwork} ->
  #         conn
  #         |> put_flash(:info, "Artwork updated successfully.")
  #         |> redirect(to: artwork_path(conn, :show, artwork))
  #       {:error, %Ecto.Changeset{} = changeset} ->
  #         render(conn, "edit.html", artwork: artwork, changeset: changeset)
  #     end
  #   end

  #   def delete(conn, %{"id" => id}) do
  #     artwork = Portfolio.get_artwork!(id)
  #     {:ok, _artwork} = Portfolio.delete_artwork(artwork)

  #     conn
  #     |> put_flash(:info, "Artwork deleted successfully.")
  #     |> redirect(to: artwork_path(conn, :index))
  #   end
end
