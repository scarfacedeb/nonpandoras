defmodule Nonpandoras.Admin.Categories do
  @moduledoc """
  The Admin context.
  """

  import Ecto.Query, warn: false
  alias Nonpandoras.Repo

  alias Nonpandoras.Portfolio.Category

  @doc "Returns the list of categories"
  def list_categories do
    Category
    |> order_by(desc: :id)
    |> Repo.all()
  end

  @doc "Gets a single category."
  def get_category!(slug), do: Repo.get_by(Category, slug: slug)

  @doc "Creates a category."
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc "Updates a category."
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc "Deletes a Category."
  def delete_category(%Category{} = category) do
    category
    |> Repo.delete()
  end

  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end
end
