defmodule NonpandorasWeb.Admin.PageController do
  use NonpandorasWeb, :controller

  alias Nonpandoras.Admin.Pages
  alias Nonpandoras.Portfolio.Page

  plug :put_layout, {NonpandorasWeb.LayoutView, "admin.html"}

  def index(conn, _params) do
    pages = Pages.list_pages()
    render(conn, "index.html", pages: pages)
  end

  def new(conn, _params) do
    changeset = Pages.change_page(%Page{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"page" => page_params}) do
    case Pages.create_page(page_params) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page created successfully.")
        |> redirect(to: Routes.admin_page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    page = Pages.get_page!(id)
    changeset = Pages.change_page(page)
    render(conn, "edit.html", page: page, changeset: changeset)
  end

  def update(conn, %{"id" => id, "page" => page_params}) do
    page = Pages.get_page!(id)

    case Pages.update_page(page, page_params) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page updated successfully.")
        |> redirect(to: Routes.admin_page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", page: page, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    page = Pages.get_page!(id)
    {:ok, _page} = Pages.delete_page(page)

    conn
    |> put_flash(:info, "Page deleted successfully.")
    |> redirect(to: Routes.admin_page_path(conn, :index))
  end
end
