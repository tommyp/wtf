defmodule Wtf.Repo.Migrations.CreateAreas do
  use Ecto.Migration

  def change do
    create table(:areas) do
      add :name, :string
      add :lat, :float
      add :lng, :float
      add :refreshed_at, :naive_datetime

      timestamps()
    end

  end
end
