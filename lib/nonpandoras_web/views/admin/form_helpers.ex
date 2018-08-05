defmodule NonpandorasWeb.Admin.FormHelpers do
  use Phoenix.HTML

  def input(form, field, opts \\ []) do
    type = opts[:using] || Phoenix.HTML.Form.input_type(form, field)

    wrapper_opts = [class: "admin-field #{state_class(form, field)}"]
    control_opts = [class: "admin-field__control"]
    label_opts = [class: "admin-field__label"]
    input_opts = opts ++ [class: "admin-field__input"]

    content_tag :div, wrapper_opts do
      label = label(form, field, humanize(field), label_opts)

      control =
        content_tag :div, control_opts do
          input = input(type, form, field, input_opts)
          error = NonpandorasWeb.ErrorHelpers.error_tag(form, field)
          [input, error || ""]
        end

      [label, control]
    end
  end

  defp state_class(form, field) do
    cond do
      # The form was not yet submitted
      !form.source.action -> ""
      form.errors[field] -> "has-error"
      true -> "has-success"
    end
  end

  # Implement clauses below for custom inputs.
  defp input(:select, form, field, input_opts) do
    {options, input_opts} = Keyword.pop(input_opts, :options, [])
    apply(Phoenix.HTML.Form, :select, [form, field, options, input_opts])
  end

  defp input(type, form, field, input_opts) do
    apply(Phoenix.HTML.Form, type, [form, field, input_opts])
  end
end
