defmodule FirestormData.PostsTest do
  use FirestormData.DataCase, async: false

  import FirestormData.Posts
  alias FirestormData.Posts.Post

  setup do
    user = insert(:user)
    thread = insert(:thread, user: user)
    {:ok, user: user, thread: thread}
  end

  test "creating a post in a thread", %{thread: thread, user: user} do
    assert {:ok, %Post{} = post} = create_post(thread, user, %{body: "Some body"})
    assert post.thread_id == thread.id
    assert post.user_id == user.id
    assert post.body == "Some body"
  end
end
