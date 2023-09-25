defmodule DedGrimory.Type.Range do
  use Ecto.Type

  alias DedGrimory.Type.Range

  defstruct [:meter, :feet]

  @type t() :: %Range{
          meter: number(),
          feet: number()
        }

  @spec type :: :integer
  def type, do: :integer

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

  @spec load(integer()) :: :error | {:ok, Range.t()}
  def load(block) when is_integer(block) do
    meter = to_meter(block: block)
    feet = to_feet(block: block)
    range = %Range{meter: meter, feet: feet}

    {:ok, range}
  end

  def load(_), do: :error

  @spec dump(Range.t()) :: :error | {:ok, integer}
  def dump(%Range{} = data) when is_valid(data),
    do: {:ok, to_block(meter: data.meter)}

  def dump(_), do: :error

  # Helpers
  defp valid?(%Range{meter: meter, feet: feet})
       when is_number(meter) and is_number(feet),
       do: to_block(meter: meter) == to_block(feet: feet)

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
