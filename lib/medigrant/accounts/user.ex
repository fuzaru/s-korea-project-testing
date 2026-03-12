defmodule Medigrant.Accounts.User do
  @moduledoc """
  The User schema represents a user in the system.
  It includes fields for email, name, and password hash.
  The changeset function is used to validate and cast user data when creating or updating a user record.
  It ensures that the email, name, and password hash are present and that the email is unique in the database.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :password_hash])
    |> validate_required([:email, :name, :password_hash])
    |> unique_constraint(:email)
  end
end
