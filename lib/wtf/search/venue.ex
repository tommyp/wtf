defmodule Wtf.Search.Venue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "venues" do
    field :category, :string
    field :name, :string
    field :source_url, :string
    field :source_id, :string
    belongs_to(:area, Wtf.Search.Area)

    timestamps()
  end

  @doc false
  def changeset(venue, attrs) do
    venue
    |> cast(attrs, [:source_url, :name, :category, :source_id])
    |> validate_required([:name, :category, :source_id])
  end
end
