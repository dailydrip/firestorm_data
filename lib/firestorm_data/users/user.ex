defmodule FirestormData.Users.User do
  @moduledoc """
  Schema for forum users.
  """

  use FirestormData.Data, :model
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

  schema "firestorm_users_users" do
    field(:email, :string)
    field(:name, :string)
    field(:username, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    field(:api_token, :string)

    timestamps()
  end

  @required_fields ~w(email api_token)a
  @optional_fields ~w(username name)

  def changeset(%__MODULE__{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:username)
  end

  def admin_changeset(%__MODULE__{} = user, attrs \\ %{}) do
    user
    |> changeset(attrs)
  end
end
