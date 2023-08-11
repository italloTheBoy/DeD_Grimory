defmodule DedGrimoryWeb.MagicJSON do
  alias DedGrimory.Grimory.Magic

  @spec list(%{:magics => [Magic.t()]}) :: %{data: list}
  @doc """
  Renders a list of magics identifications.
  """
  def list(%{magics: magics}) do
    %{data: for(magic <- magics, do: id_data(magic))}
  end

  @spec identfy(%{magic: Magic.t()}) :: %{
          data: %{id: any, name: any}
        }
  @doc """
  Renders a magic identification.
  """
  def identfy(%{magic: magic}) do
    %{data: id_data(magic)}
  end

  @spec show(%{magic: Magic.t()}) :: %{data: map}
  @doc """
  Renders a complete magic data.
  """
  def show(%{magic: magic}) do
    %{data: magic_data(magic)}
  end

  defp id_data(%Magic{} = magic), do: %{id: magic.id, name: magic.name}
  defp magic_data(%Magic{} = magic), do: magic
end
