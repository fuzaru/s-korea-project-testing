defmodule Medigrant.Accounts.User do
  @moduledoc """
  User schema.
  It includes fields for email, name, and password hash.
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
