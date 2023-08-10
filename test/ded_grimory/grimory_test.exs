defmodule DedGrimory.GrimoryTest do
  use DedGrimory.DataCase

  alias DedGrimory.Grimory

  describe "magics" do
    alias DedGrimory.Grimory.Magic

    import DedGrimory.GrimoryFixtures

    @invalid_attrs %{}

    test "list_magics/0 returns all magics" do
      magic = magic_fixture()
      assert Grimory.list_magics() == [magic]
    end

    test "get_magic!/1 returns the magic with given id" do
      magic = magic_fixture()
      assert Grimory.get_magic!(magic.id) == magic
    end

    test "create_magic/1 with valid data creates a magic" do
      valid_attrs = %{}

      assert {:ok, %Magic{} = magic} = Grimory.create_magic(valid_attrs)
    end

    test "create_magic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Grimory.create_magic(@invalid_attrs)
    end

    test "update_magic/2 with valid data updates the magic" do
      magic = magic_fixture()
      update_attrs = %{}

      assert {:ok, %Magic{} = magic} = Grimory.update_magic(magic, update_attrs)
    end

    test "update_magic/2 with invalid data returns error changeset" do
      magic = magic_fixture()
      assert {:error, %Ecto.Changeset{}} = Grimory.update_magic(magic, @invalid_attrs)
      assert magic == Grimory.get_magic!(magic.id)
    end

    test "delete_magic/1 deletes the magic" do
      magic = magic_fixture()
      assert {:ok, %Magic{}} = Grimory.delete_magic(magic)
      assert_raise Ecto.NoResultsError, fn -> Grimory.get_magic!(magic.id) end
    end

    test "change_magic/1 returns a magic changeset" do
      magic = magic_fixture()
      assert %Ecto.Changeset{} = Grimory.change_magic(magic)
    end
  end
end
