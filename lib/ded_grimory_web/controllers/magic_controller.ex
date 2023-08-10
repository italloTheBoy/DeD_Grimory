defmodule DedGrimoryWeb.MagicController do
  use DedGrimoryWeb, :controller

  alias DedGrimory.Grimory
  alias DedGrimory.Grimory.Magic

  action_fallback DedGrimoryWeb.FallbackController

  def index(conn, _params) do
    magics = Grimory.list_magics()
    render(conn, :index, magics: magics)
  end

  def create(conn, %{"magic" => magic_params}) do
    with {:ok, %Magic{} = magic} <- Grimory.create_magic(magic_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/magics/#{magic.id}")
      |> render(:show, magic: magic)
    end
  end

  def show(conn, %{"id" => id}) do
    magic = Grimory.get_magic!(id)
    render(conn, :show, magic: magic)
  end

  def update(conn, %{"id" => id, "magic" => magic_params}) do
    magic = Grimory.get_magic!(id)

    with {:ok, %Magic{} = magic} <- Grimory.update_magic(magic, magic_params) do
      render(conn, :show, magic: magic)
    end
  end

  def delete(conn, %{"id" => id}) do
    magic = Grimory.get_magic!(id)

    with {:ok, %Magic{}} <- Grimory.delete_magic(magic) do
      send_resp(conn, :no_content, "")
    end
  end
end
