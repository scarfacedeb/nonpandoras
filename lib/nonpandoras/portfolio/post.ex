defmodule Nonpandoras.Portfolio.Post do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset

  @derive {Phoenix.Param, key: :slug}
  schema "posts" do
    field :title, :string
    field :summary, :string
    field :body, :string

    field :slug, :string
    field :image, Nonpandoras.Image.Type

    field :is_published, :boolean
    field :is_homepage, :boolean
    field :published_at, :date

    timestamps()
  end

  @cast_attrs ~w[title summary body slug is_published is_homepage published_at]a
  @required_attrs ~w[slug title]a
  def changeset(%__MODULE__{} = post, attrs) do
    post
    |> cast(attrs, @cast_attrs)
    |> cast_attachments(attrs, [:image])
    |> validate_required(@required_attrs)
  end
end
