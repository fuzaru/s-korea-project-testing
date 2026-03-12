defmodule Medigrant.Repo.Migrations.CreateDoctors do
  use Ecto.Migration

  def change do
    create table(:doctors) do
      add :name, :string, null: false
      add :specialization, :string, null: false
      add :license_number, :string, null: false

      timestamps()
    end

    create unique_index(:doctors, [:license_number])
  end
end
