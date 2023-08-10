defmodule DedGrimoryWeb.MagicControllerTest do
  use DedGrimoryWeb.ConnCase

  import DedGrimory.GrimoryFixtures

  alias DedGrimory.Grimory.Magic

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all magics", %{conn: conn} do
      conn = get(conn, ~p"/api/magics")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create magic" do
    test "renders magic when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/magics", magic: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/magics/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/magics", magic: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update magic" do
    setup [:create_magic]

    test "renders magic when data is valid", %{conn: conn, magic: %Magic{id: id} = magic} do
      conn = put(conn, ~p"/api/magics/#{magic}", magic: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/magics/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, magic: magic} do
      conn = put(conn, ~p"/api/magics/#{magic}", magic: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete magic" do
    setup [:create_magic]

    test "deletes chosen magic", %{conn: conn, magic: magic} do
      conn = delete(conn, ~p"/api/magics/#{magic}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/magics/#{magic}")
      end
    end
  end

  defp create_magic(_) do
    magic = magic_fixture()
    %{magic: magic}
  end
end
