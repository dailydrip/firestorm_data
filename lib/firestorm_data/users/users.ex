defmodule FirestormData.Users do
  @moduledoc """
  Users can interact with the forum in an authenticated manner.
  """

  alias FirestormData.{
    Repo,
    Users.User
  }

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_user(map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def create_user(attrs \\ %{}) do
    attrs =
      attrs
      |> Map.put(:api_token, generate_api_token())

    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @spec get_user(String.t()) :: {:ok, User.t()} | {:error, :no_such_user}
  def get_user(id) do
    case Repo.get(User, id) do
      nil -> {:error, :no_such_user}
      user -> {:ok, user}
    end
  end

  defp generate_api_token(), do: UUID.uuid4()
end
