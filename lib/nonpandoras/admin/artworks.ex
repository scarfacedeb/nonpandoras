defmodule Nonpandoras.Admin.Artworks do
  @moduledoc """
  The Admin context.
  """

  import Ecto.Query, warn: false
  alias Nonpandoras.Repo

  alias Nonpandoras.Portfolio.{Artwork, Category}

  @doc "Returns the list of artworks"
  def list_artworks do
    Artwork
    |> order_by(desc: :id)
    |> Repo.all()
  end

  @doc "Gets a single artwork."
  def get_artwork!(slug), do: Repo.get_by(Artwork, slug: slug)

  @doc "Creates a artwork."
  def create_artwork(attrs \\ %{}) do
    %Artwork{}
    |> Artwork.changeset(attrs)
    |> Repo.insert()
  end

  @doc "Updates a artwork."
  def update_artwork(%Artwork{} = artwork, attrs) do
    artwork
    |> Artwork.changeset(attrs)
    |> Repo.update()
  end

  @doc "Deletes a Artwork."
  def delete_artwork(%Artwork{} = artwork) do
    artwork
    |> Repo.delete()
  end

  def change_artwork(%Artwork{} = artwork) do
    Artwork.changeset(artwork, %{})
  end

  def category_options do
    Category
    |> Ecto.Query.select([c], {c.slug, c.id})
    |> Repo.all()
  end
end
