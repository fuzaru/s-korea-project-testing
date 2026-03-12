defmodule Medigrant.Accounts.Doctor do
  @moduledoc """
  Doctor schema.
  It includes fields for name, specialization, and license number.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "doctors" do
    field :name, :string
    field :specialization, :string
    field :license_number, :string

    timestamps()
  end

  @doc false
  def changeset(doctor, attrs) do
    doctor
    |> cast(attrs, [:name, :specialization, :license_number])
    |> validate_required([:name, :specialization, :license_number])
    |> unique_constraint(:license_number)
  end
end
