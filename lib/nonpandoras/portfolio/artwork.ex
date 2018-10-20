defmodule Nonpandoras.Portfolio.Artwork do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset

  alias Nonpandoras.Portfolio.{Artwork, Category}

  @derive {Phoenix.Param, key: :slug}
  schema "artworks" do
    field :title, :string
    field :subtitle, :string
    field :description, :string

    field :year, :string
    field :technique, :string
    field :dimensions, :string

    field :slug, :string
    field :is_published, :boolean, default: true
    field :image, Nonpandoras.Image.Type

    belongs_to :category, Category

    timestamps()
  end

  @cast_attrs ~w[category_id slug is_published year dimensions title subtitle description technique]a
  @required_attrs ~w[category_id slug image title]a
  def changeset(%Artwork{} = artwork, attrs) do
    artwork
    |> cast(attrs, @cast_attrs)
    |> cast_attachments(attrs, [:image])
    |> validate_required(@required_attrs)
  end
end
