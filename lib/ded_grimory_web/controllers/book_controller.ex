defmodule DedGrimoryWeb.BookController do
  use DedGrimoryWeb, :controller

  alias DedGrimory.Grimory
  alias DedGrimory.Grimory.Book

  action_fallback DedGrimoryWeb.FallbackController

  def index(conn, _params) do
    books = Grimory.list_books()
    render(conn, :index, books: books)
  end

  def create(conn, %{"book" => book_params}) do
    with {:ok, %Book{} = book} <- Grimory.create_book(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/books/#{book}")
      |> render(:show, book: book)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Grimory.get_book!(id)
    render(conn, :show, book: book)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Grimory.get_book!(id)

    with {:ok, %Book{} = book} <- Grimory.update_book(book, book_params) do
      render(conn, :show, book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Grimory.get_book!(id)

    with {:ok, %Book{}} <- Grimory.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end
end
