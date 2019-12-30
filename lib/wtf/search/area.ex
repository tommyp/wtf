defmodule Wtf.Search.Area do
  use Ecto.Schema
  import Ecto.Changeset

  schema "areas" do
    field :lat, :float
    field :lng, :float
    field :name, :string
    field :refreshed_at, :naive_datetime
    has_many(:venues, Wtf.Search.Venue)

    timestamps()
  end

  @doc false
  def changeset(area, attrs) do
    area
    |> cast(attrs, [:name, :lat, :lng, :refreshed_at])
    |> validate_required([:name, :lat, :lng, :refreshed_at])
  end
end
