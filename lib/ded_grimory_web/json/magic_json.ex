defmodule DedGrimoryWeb.MagicJSON do
  alias DedGrimory.Grimory.Magic

  @spec list(%{:magics => [Magic.t()]}) :: %{data: [Magic.t()]}
  @doc """
  Renders a list of magics.
  """
  def list(%{magics: magics}) do
    %{data: for(magic <- magics, do: data(magic))}
  end

  @spec show(%{magic: Magic.t()}) :: %{data: Magic.t()}
  @doc """
  Renders a single magic.
  """
  def show(%{magic: magic}) do
    %{data: data(magic)}
  end

  defp data(%Magic{} = magic), do: magic
end
