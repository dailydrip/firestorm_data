defmodule FirestormData.Posts.Post do
  @moduledoc """
  Schema for forum posts.
  """

  use FirestormData.Data, :model

  alias FirestormData.{
    Users.User,
    Threads.Thread,
    Posts.Post
  }

  @type t :: %Post{
          id: String.t(),
          body: String.t(),
          thread: Thread.t() | Ecto.Association.NotLoaded.t(),
          user: User.t() | Ecto.Association.NotLoaded.t(),
          oembeds: nil | [term()],
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }
  schema "firestorm_posts_posts" do
    field(:body, :string)
    belongs_to(:thread, Thread)
    belongs_to(:user, User)
    # has_many(:views, {"forums_posts_views", View}, foreign_key: :assoc_id)

    # many_to_many(
    #   :viewers,
    #   User,
    #   join_through: "forums_posts_views",
    #   join_keys: [assoc_id: :id, user_id: :id]
    # )

    field(:oembeds, :any, virtual: true)

    timestamps()
  end

  def changeset(%__MODULE__{} = post, attrs \\ %{}) do
    post
    |> cast(attrs, [:body, :thread_id, :user_id])
    |> validate_required([:body, :thread_id, :user_id])
  end
end
