defmodule Chat.ChatRoomTest do
  use Chat.DataCase

  alias Chat.ChatRoom

  describe "rooms" do
    alias Chat.ChatRoom.Rooms

    import Chat.ChatRoomFixtures

    @invalid_attrs %{name: nil}

    test "list_rooms/0 returns all rooms" do
      rooms = rooms_fixture()
      assert ChatRoom.list_rooms() == [rooms]
    end

    test "get_rooms!/1 returns the rooms with given id" do
      rooms = rooms_fixture()
      assert ChatRoom.get_rooms!(rooms.id) == rooms
    end

    test "create_rooms/1 with valid data creates a rooms" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Rooms{} = rooms} = ChatRoom.create_rooms(valid_attrs)
      assert rooms.name == "some name"
    end

    test "create_rooms/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ChatRoom.create_rooms(@invalid_attrs)
    end

    test "update_rooms/2 with valid data updates the rooms" do
      rooms = rooms_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Rooms{} = rooms} = ChatRoom.update_rooms(rooms, update_attrs)
      assert rooms.name == "some updated name"
    end

    test "update_rooms/2 with invalid data returns error changeset" do
      rooms = rooms_fixture()
      assert {:error, %Ecto.Changeset{}} = ChatRoom.update_rooms(rooms, @invalid_attrs)
      assert rooms == ChatRoom.get_rooms!(rooms.id)
    end

    test "delete_rooms/1 deletes the rooms" do
      rooms = rooms_fixture()
      assert {:ok, %Rooms{}} = ChatRoom.delete_rooms(rooms)
      assert_raise Ecto.NoResultsError, fn -> ChatRoom.get_rooms!(rooms.id) end
    end

    test "change_rooms/1 returns a rooms changeset" do
      rooms = rooms_fixture()
      assert %Ecto.Changeset{} = ChatRoom.change_rooms(rooms)
    end
  end
end
