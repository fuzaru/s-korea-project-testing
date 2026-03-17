defmodule Medigrant.Appointment do
  @moduledoc """
  Appointment context for managing appointments and related workflows.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookings" do
    field :patient_id, :integer
    field :doctor_id, :integer
    field :scheduled_time, :utc_datetime
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:patient_id, :doctor_id, :scheduled_time, :status])
    |> validate_required([:patient_id, :doctor_id, :scheduled_time, :status])
  end
end

# @spec book_appointment(map()) :: {:ok, map()} | {:error, term()}
# def book_appointment(params) when is_map(params) do
#   Bookings.create_booking(params)
# end

# @spec get_appointment(String.t()) :: {:ok, map()} | {:error, term()}
# def get_appointment(appointment_id) when is_binary(appointment_id) do
#   Bookings.get_booking(appointment_id)
# end
