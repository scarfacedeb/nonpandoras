defmodule Nonpandoras.Portfolio.Page do
  use Ecto.Schema

  import Ecto.Changeset

  @derive {Phoenix.Param, key: :slug}
  schema "pages" do
    field :title, :string
    field :body, :string

    field :slug, :string
    field :is_published, :boolean
    field :is_sidebar, :boolean
    field :position, :float

    timestamps()
  end

  @cast_attrs ~w[title body slug is_published is_sidebar position]a
  @required_attrs ~w[title slug]a
  def changeset(%__MODULE__{} = page, attrs) do
    page
    |> cast(attrs, @cast_attrs)
    |> validate_required(@required_attrs)
  end
end
