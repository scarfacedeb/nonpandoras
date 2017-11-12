defmodule Nonpandoras.Portfolio do
  import Ecto.Query, warn: false
  alias Nonpandoras.Repo

  alias Nonpandoras.Portfolio.Artwork

  def list_artworks_in_category(category_id) do
    Repo.all(Artwork)
  end

  def get_artwork!(id), do: Repo.get!(Artwork, id)

  def create_artwork(attrs \\ %{}) do
    %Artwork{}
    |> Artwork.changeset(attrs)
    |> Repo.insert()
  end

  def update_artwork(%Artwork{} = artwork, attrs) do
    artwork
    |> Artwork.changeset(attrs)
    |> Repo.update()
  end

  def delete_artwork(%Artwork{} = artwork) do
    Repo.delete(artwork)
  end

  def change_artwork(%Artwork{} = artwork) do
    Artwork.changeset(artwork, %{})
  end
end
