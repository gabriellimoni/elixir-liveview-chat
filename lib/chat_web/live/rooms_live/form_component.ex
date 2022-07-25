defmodule ChatWeb.RoomsLive.FormComponent do
  use ChatWeb, :live_component

  alias Chat.ChatRoom

  @impl true
  def update(%{rooms: rooms} = assigns, socket) do
    changeset = ChatRoom.change_rooms(rooms)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"rooms" => rooms_params}, socket) do
    changeset =
      socket.assigns.rooms
      |> ChatRoom.change_rooms(rooms_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"rooms" => rooms_params}, socket) do
    save_rooms(socket, socket.assigns.action, rooms_params)
  end

  defp save_rooms(socket, :edit, rooms_params) do
    case ChatRoom.update_rooms(socket.assigns.rooms, rooms_params) do
      {:ok, _rooms} ->
        {:noreply,
         socket
         |> put_flash(:info, "Rooms updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_rooms(socket, :new, rooms_params) do
    case ChatRoom.create_rooms(rooms_params) do
      {:ok, _rooms} ->
        {:noreply,
         socket
         |> put_flash(:info, "Rooms created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
