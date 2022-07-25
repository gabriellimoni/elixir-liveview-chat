defmodule ChatWeb.RoomsLive.Show do
  use ChatWeb, :live_view

  alias Chat.ChatRoom

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:rooms, ChatRoom.get_rooms!(id))}
  end

  defp page_title(:show), do: "Show Rooms"
  defp page_title(:edit), do: "Edit Rooms"
end
