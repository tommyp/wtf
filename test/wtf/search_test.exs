defmodule Wtf.SearchTest do
  use Wtf.DataCase

  alias Wtf.Search

  describe "areas" do
    alias Wtf.Search.Area

    @valid_attrs %{lat: 120.5, lng: 120.5, name: "some name", refreshed_at: ~N[2010-04-17 14:00:00]}
    @update_attrs %{lat: 456.7, lng: 456.7, name: "some updated name", refreshed_at: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{lat: nil, lng: nil, name: nil, refreshed_at: nil}

    def area_fixture(attrs \\ %{}) do
      {:ok, area} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Search.create_area()

      area
    end

    test "list_areas/0 returns all areas" do
      area = area_fixture()
      assert Search.list_areas() == [area]
    end

    test "get_area!/1 returns the area with given id" do
      area = area_fixture()
      assert Search.get_area!(area.id) == area
    end

    test "create_area/1 with valid data creates a area" do
      assert {:ok, %Area{} = area} = Search.create_area(@valid_attrs)
      assert area.lat == 120.5
      assert area.lng == 120.5
      assert area.name == "some name"
      assert area.refreshed_at == ~N[2010-04-17 14:00:00]
    end

    test "create_area/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Search.create_area(@invalid_attrs)
    end

    test "update_area/2 with valid data updates the area" do
      area = area_fixture()
      assert {:ok, %Area{} = area} = Search.update_area(area, @update_attrs)
      assert area.lat == 456.7
      assert area.lng == 456.7
      assert area.name == "some updated name"
      assert area.refreshed_at == ~N[2011-05-18 15:01:01]
    end

    test "update_area/2 with invalid data returns error changeset" do
      area = area_fixture()
      assert {:error, %Ecto.Changeset{}} = Search.update_area(area, @invalid_attrs)
      assert area == Search.get_area!(area.id)
    end

    test "delete_area/1 deletes the area" do
      area = area_fixture()
      assert {:ok, %Area{}} = Search.delete_area(area)
      assert_raise Ecto.NoResultsError, fn -> Search.get_area!(area.id) end
    end

    test "change_area/1 returns a area changeset" do
      area = area_fixture()
      assert %Ecto.Changeset{} = Search.change_area(area)
    end
  end
end
