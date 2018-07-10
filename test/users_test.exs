defmodule FirestormData.UsersTest do
  use FirestormData.DataCase, async: false

  import FirestormData.Users
  alias FirestormData.Users.User

  test "create_user/1 with valid data creates a user" do
    attrs = %{email: "some email", name: "some name", username: "some username"}
    assert {:ok, %User{} = user} = create_user(attrs)
    assert user.email == "some email"
    assert user.name == "some name"
    assert user.username == "some username"
  end

  test "create_user/1 with invalid data returns error changeset" do
    attrs = %{email: "email@example.com", name: "some name", username: nil}
    assert {:error, changeset} = create_user(attrs)
    assert "can't be blank" in errors_on(changeset).username
  end

  test "get_user returns the user with given id" do
    user = insert(:user)
    assert {:ok, %User{}} = get_user(user.id)
  end
end
