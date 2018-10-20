defmodule Mix.Tasks.Nonpandoras.Seeds do
  use Mix.Task
  import Mix.Ecto

  alias Nonpandoras.Repo
  alias Nonpandoras.Portfolio
  alias Nonpandoras.Portfolio.Artwork

  @shortdoc "Import initial seeds"
  @files_dir Path.expand("./materials/")

  def run(_) do
    ensure_started(Repo, [])
    upload_images()
  end

  defp upload_images do
    Path.join([@files_dir, "artworks", "*"])
    |> Path.wildcard()
    |> Enum.map(&upload_image/1)
  end

  defp upload_image(path) do
    import Ecto.Query

    filename = Path.basename(path)
    file = %Plug.Upload{filename: filename, path: path}

    artwork =
      Artwork
      |> where(fragment("image") == ^filename)
      |> Repo.one()

    case artwork do
      nil -> IO.puts("No row for #{filename}")
      _ -> Artwork.changeset(artwork, %{image: file}) |> Repo.update!()
    end
  end
end
