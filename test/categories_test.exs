defmodule FirestormData.CategoriesTest do
  use FirestormData.DataCase, async: false

  import FirestormData.Categories
  alias FirestormData.Categories.Category

  # test "list_categories/1 returns all categories" do
  #   category = insert(:category)
  #   assert list_categories() == [category]
  # end

  #
  test "get_category! returns the category with given id" do
    category = insert(:category)
    assert get_category(category.id) == {:ok, category}
  end

  test "create_category/1 with valid data creates a category" do
    attrs = %{title: "some title"}
    assert {:ok, %Category{} = category} = create_category(attrs)
    assert category.title == "some title"
  end

  test "create_category/1 automatically generates a slug" do
    attrs = %{title: "some title"}
    assert {:ok, %Category{} = category} = create_category(attrs)
    assert category.slug == "some-title"
    assert {:ok, %Category{} = category} = create_category(attrs)
    assert category.slug == "some-title-1"
  end

  test "create_category/1 with invalid data returns error changeset" do
    assert {:error, changeset} = create_category(%{})
    assert "can't be blank" in errors_on(changeset).title
  end

  test "update_category/2 with valid data updates the category" do
    category = insert(:category)
    attrs = %{title: "new title"}
    assert {:ok, %Category{} = category} = update_category(category, attrs)
    assert category.title == attrs.title
  end

  test "update_category/2 with invalid data returns error changeset" do
    category = insert(:category)
    assert {:error, changeset} = update_category(category, %{title: ""})
    assert "can't be blank" in errors_on(changeset).title
  end

  test "delete_category/1 deletes the category" do
    category = insert(:category)
    assert {:ok, %Category{}} = delete_category(category)
    assert {:error, :no_such_category} = get_category(category.id)
  end
end
