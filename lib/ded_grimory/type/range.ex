defmodule DedGrimory.Type.Range do
  use Ecto.Type

  alias DedGrimory.Type.Range

  defstruct [:meter, :feet]

  @type t() ::
          %Range{
            meter: number(),
            feet: number()
          }
          | String.t()

  @special_range ["self", "touch", "sight"]

  @spec type :: :varchar
  def type, do: :varchar

  @spec cast(Range.t() | integer()) :: :error | {:ok, Range.t()}
  def cast(data) when is_integer(data),
    do:
      %Range{
        meter: to_meter(block: data),
        feet: to_feet(block: data)
      }
      |> cast()

  def cast(%Range{meter: meter, feet: nil}) when is_number(meter),
    do: to_block(meter: meter) |> cast()

  def cast(%Range{meter: nil, feet: feet}) when is_number(feet),
    do: to_block(feet: feet) |> cast()

  def cast(data) do
    if valid?(data) do
      {:ok, data}
    else
      :error
    end
  end

  @spec load(String.t()) :: :error | {:ok, Range.t()}
  def load(data) when data in @special_range, do: {:ok, data}

  def load(data) do
    case Integer.parse(data) do
      {block, _} ->
        meter = to_meter(block: block)
        feet = to_feet(block: block)

        range = %Range{meter: meter, feet: feet}

        {:ok, range}

      _ ->
        :error
    end
  end

  @spec dump(Range.t()) :: :error | {:ok, integer()}
  def dump(data) do
    cond do
      data in @special_range and valid?(data) ->
        {:ok, data}

      is_struct(data, Range) and valid?(data) ->
        block =
          to_block(meter: data.meter)
          |> Integer.to_string()

        {:ok, block}

      true ->
        :error
    end
  end

  # Helpers
  defp valid?(%Range{meter: meter, feet: feet})
       when is_number(meter) and is_number(feet),
       do: to_block(meter: meter) == to_block(feet: feet)

  defp valid?(data) when data in @special_range, do: true
  defp valid?(_data), do: false

  defp to_block(meter: data), do: trunc(data * 10) |> div(15)
  defp to_block(feet: data), do: trunc(data) |> div(5)

  defp do_to_feet(data), do: data * 5
  defp to_feet(meter: data), do: to_block(meter: data) |> do_to_feet()
  defp to_feet(block: data), do: do_to_feet(data)

  defp do_to_meter(data), do: data * 1.5
  defp to_meter(feet: data), do: to_block(feet: data) |> do_to_meter()
  defp to_meter(block: data), do: do_to_meter(data)
end
