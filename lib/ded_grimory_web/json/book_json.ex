defmodule DedGrimoryWeb.BookJSON do
  alias DedGrimory.Grimory.Book

  @spec list(%{:books => [Book.t()]}) :: %{data: [Book.t()]}
  @doc """
  Renders a list of books.
  """
  def list(%{books: books}) do
    %{data: for(book <- books, do: data(book))}
  end

  @spec show(%{:book => Book.t()}) :: %{data: Book.t()}
  @doc """
  Renders a single book.
  """
  def show(%{book: book}) do
    %{data: data(book)}
  end

  defp data(%Book{} = book), do: book
end
