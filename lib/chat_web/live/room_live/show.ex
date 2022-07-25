defmodule ChatWeb.RoomLive.Show do
  use ChatWeb, :live_view

  alias Chat.ChatRoom
  alias Phoenix.PubSub

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:username, nil) |> assign(:users, nil)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:room, ChatRoom.get_room!(id))
     |> assign(:room_id, id)
     |> assign(:messages, [])}
  end

  @impl true
  def handle_event("username", %{"user" => %{"username" => username}}, socket) do
    room_id = socket.assigns.room_id
    ChatWeb.Presence.track(self(), room_id, socket.id, %{
      username: username,
    })
    ChatWeb.Endpoint.subscribe(room_id)

    {:ok, users} = get_users(room_id)

    {:noreply,
     socket
     |> assign(:username, username)
     |> assign(:users, users)}
  end

  @impl true
  def handle_event("message", %{"message" => %{"content" => content}}, socket) do
    new_message = %{
      user: socket.assigns.username,
      content: content,
    }
    PubSub.broadcast(Chat.PubSub, socket.assigns.room_id, %{
      event: "new_message", message: new_message,
    })
    {:noreply, socket}
  end

  @impl true
  def handle_info(%{event: "presence_diff"}, socket) do
    {:ok, users} = get_users(socket.assigns.room_id)
    {:noreply, socket |> assign(:users, users)}
  end

  @impl true
  def handle_info(%{event: "new_message", message: new_message}, socket) do
    {:noreply, socket |> assign(:messages, [new_message | socket.assigns.messages])}
  end

  defp get_users(room_id) do
    users = room_id
      |> ChatWeb.Presence.list()
      |> Map.values()
      |> Enum.map(fn presence ->
        data = presence
          |> Map.get(:metas)
          |> List.first()
        %{
          username: data.username
        }
      end)
    {:ok, users}
  end
  defp page_title(:show), do: "Show Room"
  defp page_title(:edit), do: "Edit Room"
end
