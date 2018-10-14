defmodule Nonpandoras.Admin.Pages do
  @moduledoc """
  The Admin context.
  """

  import Ecto.Query, warn: false
  alias Nonpandoras.Repo

  alias Nonpandoras.Portfolio.Page

  @doc "Returns the list of pages"
  def list_pages do
    Page
    |> order_by(desc: :id)
    |> Repo.all()
  end

  @doc "Gets a single page."
  def get_page!(slug), do: Repo.get_by(Page, slug: slug)

  @doc "Creates a page."
  def create_page(attrs \\ %{}) do
    %Page{}
    |> Page.changeset(attrs)
    |> Repo.insert()
  end

  @doc "Updates a page."
  def update_page(%Page{} = page, attrs) do
    page
    |> Page.changeset(attrs)
    |> Repo.update()
  end

  @doc "Deletes a Page."
  def delete_page(%Page{} = page) do
    page
    |> Repo.delete()
  end

  def change_page(%Page{} = page) do
    Page.changeset(page, %{})
  end
end
