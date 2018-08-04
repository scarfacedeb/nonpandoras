defmodule Nonpandoras.Portfolio.Category do
  use Ecto.Schema
  use Arc.Ecto.Schema
  use Trans, translates: [:title, :description]

  import Ecto.Changeset

  alias Nonpandoras.Portfolio.{Artwork, Category}

  schema "categories" do
    field :title, :string, virtual: true
    field :description, :string, virtual: true
    field :translations, :map

    field :slug, :string
    field :image, Nonpandoras.Image.Type
    field :position, :integer

    has_many :artworks, Artwork

    timestamps()
  end

  @cast_attrs ~w[slug position translations]a
  @required_attrs ~w[slug image]a
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, @cast_attrs)
    |> cast_attachments(attrs, [:image])
    |> validate_required(@required_attrs)
  end
end
