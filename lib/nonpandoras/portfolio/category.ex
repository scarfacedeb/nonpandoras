defmodule Nonpandoras.Portfolio.Category do
  use Ecto.Schema
  use Arc.Ecto.Schema
  use Trans, translates: [:name]

  import Ecto.Changeset

  alias Nonpandoras.Portfolio.{Artwork, Category}

  schema "categories" do
    field :name, :string, virtual: true
    field :translations, :map

    field :slug, :string
    field :image, Nonpandoras.Image.Type
    field :position, :integer

    has_many :artworks, Artwork

    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:slug, :position, :translations])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:slug, :image])
  end
end
