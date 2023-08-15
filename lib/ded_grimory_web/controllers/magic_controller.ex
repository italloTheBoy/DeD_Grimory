defmodule DedGrimoryWeb.MagicController do
  use DedGrimoryWeb, :controller

  alias DedGrimory.Grimory
  alias DedGrimory.Grimory.Magic

  action_fallback DedGrimoryWeb.FallbackController

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    magics = Grimory.list_magics()
    render(conn, :list, magics: magics)
  end

  @spec create(any, map) :: Plug.Conn.t() | {:error, term()}
  def create(conn, %{"magic" => magic_params}) do
    with {:ok, %Magic{} = magic} <- Grimory.create_magic(magic_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/magic/#{magic.id}")
      |> render(:identfy, magic: magic)
    end
  end

  @spec show(any, map) :: Plug.Conn.t() | {:error, term()}
  def show(conn, %{"name" => name}) do
    with {:ok, %Magic{} = magic} <- Grimory.get_magic(name: name) do
      render(conn, :show, magic: magic)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Magic{} = magic} <- Grimory.get_magic(id) do
      render(conn, :show, magic: magic)
    end
  end

  @spec update(any, map) :: Plug.Conn.t() | {:error, term()}
  def update(conn, %{"id" => id, "magic" => magic_params}) do
    with {:ok, %Magic{} = magic} <- Grimory.get_magic(id),
         {:ok, %Magic{} = updated_magic} <- Grimory.update_magic(magic, magic_params) do
      render(conn, :identfy, magic: updated_magic)
    end
  end

  @spec delete(any, map) :: Plug.Conn.t() | {:error, term()}
  def delete(conn, %{"id" => id}) do
    with {:ok, %Magic{} = magic} <- Grimory.get_magic(id),
         {:ok, %Magic{}} <- Grimory.delete_magic(magic) do
      send_resp(conn, :no_content, "")
    end
  end
end
