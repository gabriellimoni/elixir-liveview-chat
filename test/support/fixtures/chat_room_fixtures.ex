defmodule Chat.ChatRoomFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chat.ChatRoom` context.
  """

  @doc """
  Generate a rooms.
  """
  def rooms_fixture(attrs \\ %{}) do
    {:ok, rooms} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Chat.ChatRoom.create_rooms()

    rooms
  end
end
