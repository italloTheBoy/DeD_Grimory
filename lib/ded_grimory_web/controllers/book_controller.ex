defmodule DedGrimoryWeb.BookController do
  use DedGrimoryWeb, :controller

  alias DedGrimory.Grimory
  alias DedGrimory.Grimory.Book

  action_fallback DedGrimoryWeb.FallbackController

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    books = Grimory.list_books()
    render(conn, :list, books: books)
  end

  @spec create(Plug.Conn.t(), map) :: {:error, term()} | Plug.Conn.t()
  def create(conn, %{"book" => book_params}) do
    with {:ok, %Book{} = book} <- Grimory.create_book(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/book/#{book.id}")
      |> render(:show, book: book)
    end
  end

  @spec show(Plug.Conn.t(), map) :: {:error, term()} | Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    with {:ok, %Book{} = book} <- Grimory.get_book(id) do
      render(conn, :show, book: book)
    end
  end

  def show(conn, %{"name" => name}) do
    with {:ok, %Book{} = book} <- Grimory.get_book(name: name) do
      render(conn, :show, book: book)
    end
  end

  @spec update(Plug.Conn.t(), map) :: {:error, term()} | Plug.Conn.t()
  def update(conn, %{"id" => id, "book" => book_params}) do
    with {:ok, %Book{} = book} <- Grimory.get_book(id),
         {:ok, %Book{} = updated_book} <- Grimory.update_book(book, book_params) do
      render(conn, :show, book: updated_book)
    end
  end

  @spec delete(Plug.Conn.t(), map) :: {:error, term()} | Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    with {:ok, %Book{} = book} <- Grimory.get_book(id),
         {:ok, %Book{}} <- Grimory.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end
end
