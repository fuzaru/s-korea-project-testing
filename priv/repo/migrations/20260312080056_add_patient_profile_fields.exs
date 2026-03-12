defmodule Medigrant.Repo.Migrations.AddPatientProfileFields do
  use Ecto.Migration

  def change do
    alter table(:patients) do
      add :first_name, :string
      add :last_name, :string
      add :country_code, :string
      add :mobile_number, :string
      add :date_of_birth, :date
      add :sex, :string
    end
  end
end
