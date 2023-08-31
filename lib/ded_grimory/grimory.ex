defmodule DedGrimory.Grimory do
  @moduledoc """
  The Grimory context.
  """

  import Ecto.Query, warn: false
  alias DedGrimory.Repo

  alias DedGrimory.Grimory.Magic

  @spec list_magics() :: [Magic.t()]
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

  @spec get_magic(term()) ::
          {:error, :not_found | :unprocessable_entity} | {:ok, Magic.t()}
  @doc """
  Gets a single magic.

  ## Examples

      iex> get_magic(id)
      {:ok, %Magic{}}

      iex> get_magic(id: id)
      {:ok, %Magic{}}

      iex> get_magic(name: "name")
      {:ok, %Magic{}}

      iex> get_magic(bad_id)
      {:error, :not_found}

      iex> get_magic(id: bad_id)
      {:error, :not_found}

      iex> get_magic(name: bad_name)
      {:error, :not_found}
  """
  def get_magic(id: id), do: get_magic(id)

  def get_magic(name: name) do
    case Repo.get_by(Magic, name: name) do
      %Magic{} = magic -> {:ok, magic}
      nil -> {:error, :not_found}
    end
  rescue
    _ -> {:error, :unprocessable_entity}
  end

  def get_magic(id) do
    case Repo.get(Magic, id) do
      %Magic{} = magic -> {:ok, magic}
      nil -> {:error, :not_found}
    end
  rescue
    _ -> {:error, :unprocessable_entity}
  end

  @spec create_magic(map()) :: {:ok, Magic.t()} | {:error, Ecto.Changeset.t()}
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

  @spec update_magic(
          Magic.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) ::
          {:ok, Magic.t()} | {:error, Ecto.Changeset.t()}
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

  @spec delete_magic(Magic.t()) ::
          {:ok, Magic.t()} | {:error, Ecto.Changeset.t()}
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

  alias DedGrimory.Grimory.Book

  @doc """
  Returns the list of books.

  ## Examples

      iex> list_books()
      [%Book{}, ...]

  """
  def list_books do
    Repo.all(Book)
  end

  @doc """
  Gets a single book.

  Raises `Ecto.NoResultsError` if the Book does not exist.

  ## Examples

      iex> get_book!(123)
      %Book{}

      iex> get_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book!(id), do: Repo.get!(Book, id)

  @doc """
  Creates a book.

  ## Examples

      iex> create_book(%{field: value})
      {:ok, %Book{}}

      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book.

  ## Examples

      iex> update_book(book, %{field: new_value})
      {:ok, %Book{}}

      iex> update_book(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a book.

  ## Examples

      iex> delete_book(book)
      {:ok, %Book{}}

      iex> delete_book(book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.

  ## Examples

      iex> change_book(book)
      %Ecto.Changeset{data: %Book{}}

  """
  def change_book(%Book{} = book, attrs \\ %{}) do
    Book.changeset(book, attrs)
  end
end
