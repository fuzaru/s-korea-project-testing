defmodule Medigrant.Repo.Migrations.Patients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :password_hash, :string, null: false

      timestamps()
    end
  end
end
