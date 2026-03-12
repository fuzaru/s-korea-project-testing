defmodule Medigrant.Repo.Migrations.CreateDoctors do
  use Ecto.Migration

  def change do
    create table(:doctors) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :license_number, :string, null: false
      add :password_hash, :string, null: false

      timestamps()
    end

    create unique_index(:doctors, [:email, :license_number, :password_hash])
  end
end
