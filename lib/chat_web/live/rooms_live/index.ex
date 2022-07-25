defmodule ChatWeb.RoomsLive.Index do
  use ChatWeb, :live_view

  alias Chat.ChatRoom
  alias Chat.ChatRoom.Rooms

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :rooms_collection, list_rooms())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Rooms")
    |> assign(:rooms, ChatRoom.get_rooms!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Rooms")
    |> assign(:rooms, %Rooms{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Rooms")
    |> assign(:rooms, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    rooms = ChatRoom.get_rooms!(id)
    {:ok, _} = ChatRoom.delete_rooms(rooms)

    {:noreply, assign(socket, :rooms_collection, list_rooms())}
  end

  defp list_rooms do
    ChatRoom.list_rooms()
  end
end
