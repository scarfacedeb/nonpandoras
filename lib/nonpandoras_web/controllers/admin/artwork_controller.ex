defmodule NonpandorasWeb.Admin.ArtworkController do
  use NonpandorasWeb, :controller

  alias Nonpandoras.Admin.Artworks
  alias Nonpandoras.Portfolio.Artwork

  plug :put_layout, {NonpandorasWeb.LayoutView, "admin.html"}

  def index(conn, _params) do
    artworks = Artworks.list_artworks()
    render(conn, "index.html", artworks: artworks)
  end

  def new(conn, _params) do
    changeset = Artworks.change_artwork(%Artwork{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"artwork" => artwork_params}) do
    case Artworks.create_artwork(artwork_params) do
      {:ok, artwork} ->
        conn
        |> put_flash(:info, "Artwork created successfully.")
        |> redirect(to: Routes.admin_artwork_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    artwork = Artworks.get_artwork!(id)
    changeset = Artworks.change_artwork(artwork)
    render(conn, "edit.html", artwork: artwork, changeset: changeset)
  end

  def update(conn, %{"id" => id, "artwork" => artwork_params}) do
    artwork = Artworks.get_artwork!(id)

    case Artworks.update_artwork(artwork, artwork_params) do
      {:ok, artwork} ->
        conn
        |> put_flash(:info, "Artwork updated successfully.")
        |> redirect(to: Routes.admin_artwork_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", artwork: artwork, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    artwork = Artworks.get_artwork!(id)
    {:ok, _artwork} = Artworks.delete_artwork(artwork)

    conn
    |> put_flash(:info, "Artwork deleted successfully.")
    |> redirect(to: Routes.admin_artwork_path(conn, :index))
  end
end
