defmodule Medigrant.Repo.Migrations.CreateBookings do
  use Ecto.Migration

  def change do
    create table(:bookings) do
      add :patient_id, :integer, null: false
      add :doctor_id, :integer, null: false
      add :scheduled_time, :utc_datetime, null: false
      add :status, :string, null: false

      timestamps()
    end
  end
end
