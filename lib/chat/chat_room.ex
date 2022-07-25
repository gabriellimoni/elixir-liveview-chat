defmodule Chat.ChatRoom do
  @moduledoc """
  The ChatRoom context.
  """

  import Ecto.Query, warn: false
  alias Chat.Repo

  alias Chat.ChatRoom.Rooms

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Rooms{}, ...]

  """
  def list_rooms do
    Repo.all(Rooms)
  end

  @doc """
  Gets a single rooms.

  Raises `Ecto.NoResultsError` if the Rooms does not exist.

  ## Examples

      iex> get_rooms!(123)
      %Rooms{}

      iex> get_rooms!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rooms!(id), do: Repo.get!(Rooms, id)

  @doc """
  Creates a rooms.

  ## Examples

      iex> create_rooms(%{field: value})
      {:ok, %Rooms{}}

      iex> create_rooms(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rooms(attrs \\ %{}) do
    %Rooms{}
    |> Rooms.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rooms.

  ## Examples

      iex> update_rooms(rooms, %{field: new_value})
      {:ok, %Rooms{}}

      iex> update_rooms(rooms, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rooms(%Rooms{} = rooms, attrs) do
    rooms
    |> Rooms.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rooms.

  ## Examples

      iex> delete_rooms(rooms)
      {:ok, %Rooms{}}

      iex> delete_rooms(rooms)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rooms(%Rooms{} = rooms) do
    Repo.delete(rooms)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rooms changes.

  ## Examples

      iex> change_rooms(rooms)
      %Ecto.Changeset{data: %Rooms{}}

  """
  def change_rooms(%Rooms{} = rooms, attrs \\ %{}) do
    Rooms.changeset(rooms, attrs)
  end
end
