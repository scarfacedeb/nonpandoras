defmodule NonpandorasWeb.Admin.FormHelpers do
  use Phoenix.HTML
  import NonpandorasWeb.Admin.ImageHelpers
  import NonpandorasWeb.ErrorHelpers

  def input(form, field, opts \\ []) do
    {type, opts} = Keyword.pop(opts, :using, Phoenix.HTML.Form.input_type(form, field))

    wrapper_opts = [class: "admin-field #{state_class(form, field)}"]
    control_opts = [class: "admin-field__control"]
    label_opts = [class: "admin-field__label"]
    input_opts = add_class(opts, "admin-field__input")

    content_tag :div, wrapper_opts do
      label = label(form, field, humanize(field), label_opts)

      control =
        content_tag :div, control_opts do
          input = input(type, form, field, input_opts)
          error = error_tag(form, field)
          [input, error || ""]
        end

      [label, control]
    end
  end

  # Implement clauses below for custom inputs.
  defp input(:select, form, field, input_opts) do
    {options, input_opts} = Keyword.pop(input_opts, :options, [])
    apply(Phoenix.HTML.Form, :select, [form, field, options, input_opts])
  end

  defp input(:markdown, form, field, input_opts) do
    input_opts = input_opts |> add_class("editor")
    apply(Phoenix.HTML.Form, :textarea, [form, field, input_opts])
  end

  defp input(:image, form, field, _input_opts) do
    content_tag :div, class: "admin-field__body" do
      [
        uploaded_image(form, field),
        delete_image_input(form, field),
        file_input(form, field, class: "admin-field__input"),
        error_tag(form, field)
      ]
    end
  end

  defp input(type, form, field, input_opts) do
    apply(Phoenix.HTML.Form, type, [form, field, input_opts])
  end

  defp state_class(form, field) do
    cond do
      # The form was not yet submitted
      !form.source.action -> ""
      form.errors[field] -> "has-error"
      true -> "has-success"
    end
  end

  defp add_class(opts, class) do
    Keyword.update(opts, :class, class, &(&1 <> " " <> class))
  end
end
