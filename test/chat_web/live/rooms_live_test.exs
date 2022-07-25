defmodule ChatWeb.RoomsLiveTest do
  use ChatWeb.ConnCase

  import Phoenix.LiveViewTest
  import Chat.ChatRoomFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_rooms(_) do
    rooms = rooms_fixture()
    %{rooms: rooms}
  end

  describe "Index" do
    setup [:create_rooms]

    test "lists all rooms", %{conn: conn, rooms: rooms} do
      {:ok, _index_live, html} = live(conn, Routes.rooms_index_path(conn, :index))

      assert html =~ "Listing Rooms"
      assert html =~ rooms.name
    end

    test "saves new rooms", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.rooms_index_path(conn, :index))

      assert index_live |> element("a", "New Rooms") |> render_click() =~
               "New Rooms"

      assert_patch(index_live, Routes.rooms_index_path(conn, :new))

      assert index_live
             |> form("#rooms-form", rooms: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#rooms-form", rooms: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rooms_index_path(conn, :index))

      assert html =~ "Rooms created successfully"
      assert html =~ "some name"
    end

    test "updates rooms in listing", %{conn: conn, rooms: rooms} do
      {:ok, index_live, _html} = live(conn, Routes.rooms_index_path(conn, :index))

      assert index_live |> element("#rooms-#{rooms.id} a", "Edit") |> render_click() =~
               "Edit Rooms"

      assert_patch(index_live, Routes.rooms_index_path(conn, :edit, rooms))

      assert index_live
             |> form("#rooms-form", rooms: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#rooms-form", rooms: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rooms_index_path(conn, :index))

      assert html =~ "Rooms updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes rooms in listing", %{conn: conn, rooms: rooms} do
      {:ok, index_live, _html} = live(conn, Routes.rooms_index_path(conn, :index))

      assert index_live |> element("#rooms-#{rooms.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#rooms-#{rooms.id}")
    end
  end

  describe "Show" do
    setup [:create_rooms]

    test "displays rooms", %{conn: conn, rooms: rooms} do
      {:ok, _show_live, html} = live(conn, Routes.rooms_show_path(conn, :show, rooms))

      assert html =~ "Show Rooms"
      assert html =~ rooms.name
    end

    test "updates rooms within modal", %{conn: conn, rooms: rooms} do
      {:ok, show_live, _html} = live(conn, Routes.rooms_show_path(conn, :show, rooms))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Rooms"

      assert_patch(show_live, Routes.rooms_show_path(conn, :edit, rooms))

      assert show_live
             |> form("#rooms-form", rooms: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#rooms-form", rooms: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rooms_show_path(conn, :show, rooms))

      assert html =~ "Rooms updated successfully"
      assert html =~ "some updated name"
    end
  end
end
