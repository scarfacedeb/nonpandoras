defmodule NonpandorasWeb.Admin.CategoryController do
  use NonpandorasWeb, :controller

  alias Nonpandoras.Admin.Categories
  alias Nonpandoras.Portfolio.Category

  plug :put_layout, {NonpandorasWeb.LayoutView, "admin.html"}

  def index(conn, _params) do
    categories = Categories.list_categories()
    render(conn, "index.html", categories: categories)
  end

  def new(conn, _params) do
    changeset = Categories.change_category(%Category{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"category" => category_params}) do
    case Categories.create_category(category_params) do
      {:ok, _category} ->
        conn
        |> put_flash(:info, "Category created successfully.")
        |> redirect(to: Routes.admin_category_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    category = Categories.get_category!(id)
    changeset = Categories.change_category(category)
    render(conn, "edit.html", category: category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Categories.get_category!(id)

    case Categories.update_category(category, category_params) do
      {:ok, _category} ->
        conn
        |> put_flash(:info, "Category updated successfully.")
        |> redirect(to: Routes.admin_category_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", category: category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Categories.get_category!(id)
    {:ok, _category} = Categories.delete_category(category)

    conn
    |> put_flash(:info, "Category deleted successfully.")
    |> redirect(to: Routes.admin_category_path(conn, :index))
  end
end