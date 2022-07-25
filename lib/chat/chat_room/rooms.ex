defmodule Chat.ChatRoom.Rooms do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(rooms, attrs) do
    rooms
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
