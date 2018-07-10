defmodule FirestormData.Posts do
  @moduledoc """
  Posts exist on Threads
  """

  alias FirestormData.{
    Repo,
    Posts.Post,
    Threads.Thread,
    Users.User
  }

  @doc """
  Creates a post within a thread.

  ## Examples

      iex> create_post(thread, user, %{body: "don't you think?"})
      {:ok, %Post{}}

      iex> create_post(thread, user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(%Thread{} = thread, %User{} = user, attrs) do
    attrs =
      attrs
      |> Map.put(:thread_id, thread.id)
      |> Map.put(:user_id, user.id)

    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end
end
