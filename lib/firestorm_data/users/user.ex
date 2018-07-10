defmodule FirestormData.Users.User do
  @moduledoc """
  Schema for forum users.
  """

  use Ecto.Schema
  import Ecto.Changeset, warn: false
  alias FirestormData.Users.User

  @type t :: %User{
          email: String.t(),
          name: String.t(),
          username: String.t(),
          password_hash: String.t(),
          password: nil | String.t(),
          api_token: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users_users" do
    field(:email, :string)
    field(:name, :string)
    field(:username, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    field(:api_token, :string)

    timestamps()
  end

  def changeset(%__MODULE__{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:username, :email, :name, :api_token])
    |> validate_required([:username, :name, :api_token])
    |> unique_constraint(:username)
  end

  def admin_changeset(%__MODULE__{} = user, attrs \\ %{}) do
    user
    |> changeset(attrs)
  end
end
