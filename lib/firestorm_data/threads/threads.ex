defmodule FirestormData.Threads do
  @moduledoc """
  A Thread has a series of posts within it.
  """

  alias FirestormData.{
    Repo,
    Categories.Category,
    Threads.Thread
  }

  @doc """
  Gets a thread within a category.

  ## Examples

      iex> get_thread(category, "123")
      {:ok, %Thread{}}

      iex> get_thread(category, "456")
      {:error, :no_such_thread}

  """
  @spec get_thread(Category.t(), String.t()) :: {:ok, Thread.t()} | {:error, :no_such_thread}
  def get_thread(%Category{id: category_id}, id) do
    case Repo.get_by(Thread, id: id, category_id: category_id) do
      nil -> {:error, :no_such_thread}
      thread -> {:ok, thread}
    end
  end

  @doc """
  Creates a thread.

  ## Examples

      iex> create_thread(category, user, %{title: "OTP is cool", body: "don't you think?"})
      {:ok, %Thread{}}

      iex> create_thread(category, user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_thread(category, user, attrs \\ %{}) do
    post_attrs =
      attrs
      |> Map.take([:body])
      |> Map.put(:user_id, user.id)

    thread_attrs =
      attrs
      |> Map.take([:title])
      |> Map.put(:category_id, category.id)

    %{thread: thread_attrs, post: post_attrs}
    |> Thread.new_changeset()
    |> Repo.insert()
  end

  @doc """
  Updates a thread.

  ## Examples

      iex> update_thread(thread, %{field: new_value})
      {:ok, %Thread{}}

      iex> update_thread(thread, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_thread(Thread.t(), map()) :: {:ok, Thread.t()} | {:error, Ecto.Changeset.t()}
  def update_thread(%Thread{} = thread, attrs) do
    thread
    |> Thread.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Thread.

  ## Examples

      iex> delete_thread(thread)
      {:ok, %Thread{}}

      iex> delete_thread(thread)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_thread(Thread.t()) :: {:ok, Thread.t()} | {:error, Ecto.Changeset.t()}
  def delete_thread(%Thread{} = thread) do
    Repo.delete(thread)
  end
end
