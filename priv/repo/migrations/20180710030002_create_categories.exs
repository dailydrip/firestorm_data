defmodule FirestormData.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:firestorm_categories_categories, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:title, :string)
      add(:slug, :string)

      timestamps()
    end

    create(unique_index(:firestorm_categories_categories, [:slug]))
  end
end
