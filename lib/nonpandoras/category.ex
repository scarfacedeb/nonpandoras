defmodule Nonpandoras.Category do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias Nonpandoras.{Artwork, Category}

  schema "name" do
    field :name, :string
    field :slug, :string
    field :image, Nonpandoras.Image.Type
    field :position, :integer

    has_many :artworks, Artwork

    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:name, :slug, :position])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:name, :slug, :image])
  end
end
