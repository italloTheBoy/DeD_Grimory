defmodule DedGrimory.Grimory do
  @moduledoc """
  The Grimory context.
  """

  import Ecto.Query, warn: false
  alias DedGrimory.Repo

  alias DedGrimory.Grimory.Magic

  @doc """
  Returns the list of magics.

  ## Examples

      iex> list_magics()
      [%Magic{}, ...]

  """
  def list_magics do
    Repo.all(Magic)
  end

  @doc """
  Gets a single magic.

  Raises `Ecto.NoResultsError` if the Magic does not exist.

  ## Examples

      iex> get_magic!(123)
      %Magic{}

      iex> get_magic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_magic!(id), do: Repo.get!(Magic, id)

  @doc """
  Creates a magic.

  ## Examples

      iex> create_magic(%{field: value})
      {:ok, %Magic{}}

      iex> create_magic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_magic(attrs \\ %{}) do
    %Magic{}
    |> Magic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a magic.

  ## Examples

      iex> update_magic(magic, %{field: new_value})
      {:ok, %Magic{}}

      iex> update_magic(magic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_magic(%Magic{} = magic, attrs) do
    magic
    |> Magic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a magic.

  ## Examples

      iex> delete_magic(magic)
      {:ok, %Magic{}}

      iex> delete_magic(magic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_magic(%Magic{} = magic) do
    Repo.delete(magic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking magic changes.

  ## Examples

      iex> change_magic(magic)
      %Ecto.Changeset{data: %Magic{}}

  """
  def change_magic(%Magic{} = magic, attrs \\ %{}) do
    Magic.changeset(magic, attrs)
  end
end
