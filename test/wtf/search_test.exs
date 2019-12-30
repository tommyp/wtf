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

  describe "venues" do
    alias Wtf.Search.Venue

    @valid_attrs %{category: "some category", venue_name: "some venue_name", venue_url: "some venue_url"}
    @update_attrs %{category: "some updated category", venue_name: "some updated venue_name", venue_url: "some updated venue_url"}
    @invalid_attrs %{category: nil, venue_name: nil, venue_url: nil}

    def venue_fixture(attrs \\ %{}) do
      {:ok, venue} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Search.create_venue()

      venue
    end

    test "list_venues/0 returns all venues" do
      venue = venue_fixture()
      assert Search.list_venues() == [venue]
    end

    test "get_venue!/1 returns the venue with given id" do
      venue = venue_fixture()
      assert Search.get_venue!(venue.id) == venue
    end

    test "create_venue/1 with valid data creates a venue" do
      assert {:ok, %Venue{} = venue} = Search.create_venue(@valid_attrs)
      assert venue.category == "some category"
      assert venue.venue_name == "some venue_name"
      assert venue.venue_url == "some venue_url"
    end

    test "create_venue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Search.create_venue(@invalid_attrs)
    end

    test "update_venue/2 with valid data updates the venue" do
      venue = venue_fixture()
      assert {:ok, %Venue{} = venue} = Search.update_venue(venue, @update_attrs)
      assert venue.category == "some updated category"
      assert venue.venue_name == "some updated venue_name"
      assert venue.venue_url == "some updated venue_url"
    end

    test "update_venue/2 with invalid data returns error changeset" do
      venue = venue_fixture()
      assert {:error, %Ecto.Changeset{}} = Search.update_venue(venue, @invalid_attrs)
      assert venue == Search.get_venue!(venue.id)
    end

    test "delete_venue/1 deletes the venue" do
      venue = venue_fixture()
      assert {:ok, %Venue{}} = Search.delete_venue(venue)
      assert_raise Ecto.NoResultsError, fn -> Search.get_venue!(venue.id) end
    end

    test "change_venue/1 returns a venue changeset" do
      venue = venue_fixture()
      assert %Ecto.Changeset{} = Search.change_venue(venue)
    end
  end
end
