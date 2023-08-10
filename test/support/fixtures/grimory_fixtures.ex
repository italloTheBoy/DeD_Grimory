defmodule DedGrimory.GrimoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DedGrimory.Grimory` context.
  """

  @doc """
  Generate a magic.
  """
  def magic_fixture(attrs \\ %{}) do
    {:ok, magic} =
      attrs
      |> Enum.into(%{

      })
      |> DedGrimory.Grimory.create_magic()

    magic
  end
end
