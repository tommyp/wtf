defmodule Wtf.Repo.Migrations.CreateVenues do
  use Ecto.Migration

  def change do
    create table(:venues) do
      add :name, :string
      add :category, :string
      add :source_id, :string
      add :source_url, :string, null: true
      add :area_id, references(:areas, on_delete: :nothing)

      timestamps()
    end

    create index(:venues, [:source_id])
    create index(:venues, [:area_id])
  end
end
