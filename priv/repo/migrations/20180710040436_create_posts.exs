defmodule FirestormData.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:firestorm_posts_posts, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:body, :text)

      add(
        :thread_id,
        references(:firestorm_threads_threads, type: :binary_id, on_delete: :delete_all)
      )

      add(:user_id, references(:firestorm_users_users, type: :binary_id, on_delete: :nilify_all))

      timestamps()
    end

    create(index(:firestorm_posts_posts, [:thread_id]))
    create(index(:firestorm_posts_posts, [:user_id]))
  end
end
