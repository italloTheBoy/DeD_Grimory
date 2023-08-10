defmodule DedGrimoryWeb.MagicJSON do
  alias DedGrimory.Grimory.Magic

  @doc """
  Renders a list of magics.
  """
  def index(%{magics: magics}) do
    %{data: for(magic <- magics, do: data(magic))}
  end

  @doc """
  Renders a single magic.
  """
  def show(%{magic: magic}) do
    %{data: data(magic)}
  end

  defp data(%Magic{} = magic) do
    %{
      id: magic.id
    }
  end
end
