defmodule NonpandorasWeb.Admin.ImageHelpers do
  use Phoenix.HTML
  alias Nonpandoras.Image

  def uploaded_image(%{source: %{data: data}}, field, version \\ :thumb) do
    case Map.fetch(data, field) do
      {:ok, image} ->
        {image, data}
        |> Image.url(version)
        |> img_tag()

      :error ->
        nil
    end
  end

  def delete_image_input(%{source: %{data: data}} = form, field) do
    if Map.has_key?(data, field) do
      checkbox(String.to_atom(form.name), "_delete_#{field}", value: false)
    end
  end
end
