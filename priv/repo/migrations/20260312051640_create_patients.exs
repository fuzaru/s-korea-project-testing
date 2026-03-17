defmodule Medigrant.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :first_name, :string
      add :last_name, :string
      add :country_code, :string
      add :mobile_number, :string
      add :date_of_birth, :date
      add :sex, :string
      add :password, :string, null: false
      add :password_hash, :string, null: false

      timestamps()
    end

    create unique_index(:patients, [:email])
  end
end
