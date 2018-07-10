defmodule FirestormData.Categories.Category do
  @moduledoc """
  Schema for forum categories.
  """

  use FirestormData.Data, :model

  alias FirestormData.Categories.{
    CategoryTitleSlug,
    Category
  }

  @type t :: %Category{
          title: String.t(),
          slug: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "firestorm_categories_categories" do
    field(:title, :string)
    field(:slug, CategoryTitleSlug.Type)

    timestamps()
  end

  def changeset(%__MODULE__{} = category, attrs \\ %{}) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> CategoryTitleSlug.maybe_generate_slug()
    |> CategoryTitleSlug.unique_constraint()
  end
end
