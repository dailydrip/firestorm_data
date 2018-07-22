defmodule FirestormData.ThreadsTest do
  use FirestormData.DataCase, async: false

  import FirestormData.Threads
  alias FirestormData.Threads.Thread

  setup do
    user = insert(:user)
    category = insert(:category)
    {:ok, user: user, category: category}
  end

  test "get_thread returns the thread with given id", %{category: category, user: user} do
    thread = insert(:thread, user: user, category: category)
    {:ok, returned_thread} = get_thread(category, thread.id)
    assert returned_thread.id == thread.id
  end

  test "create_thread/2 with valid data creates a thread and its first post", %{
    category: category,
    user: user
  } do
    attrs = %{title: "Some title", body: "Some body"}
    assert {:ok, %Thread{} = thread} = create_thread(category, user, attrs)
    assert thread.title == attrs.title
    # FIXME: Handle when we add posts
    # first_post = hd(thread.posts)
    # assert first_post.thread_id == thread.id
    # assert first_post.body == "some body"
  end

  test "create_thread/1 with invalid data returns error changeset", %{
    category: category,
    user: user
  } do
    assert {:error, changeset} = create_thread(category, user, %{title: nil})
    assert "can't be blank" in errors_on(changeset).title
  end

  test "create_thread/2 automatically generates a slug", %{category: category, user: user} do
    attrs = %{title: "some title", body: "some body"}
    assert {:ok, %Thread{} = thread} = create_thread(category, user, attrs)
    assert thread.slug == "some-title"
    assert {:ok, %Thread{} = thread} = create_thread(category, user, attrs)
    assert thread.slug == "some-title-1"
  end

  test "update_thread/2 with valid data updates the thread", %{category: category, user: user} do
    thread = insert(:thread, category: category, user: user)
    updated_attrs = %{title: "some updated title"}
    assert {:ok, %Thread{} = thread} = update_thread(thread, updated_attrs)
    assert thread.title == updated_attrs.title
  end

  test "update_thread/2 with invalid data returns error changeset", %{
    category: category,
    user: user
  } do
    thread = insert(:thread, category: category, user: user)
    assert {:error, changeset} = update_thread(thread, %{title: nil})
    assert "can't be blank" in errors_on(changeset).title
  end

  test "delete_thread/1 deletes the thread", %{category: category, user: user} do
    thread = insert(:thread, category: category, user: user)
    assert {:ok, %Thread{}} = delete_thread(thread)
    assert {:error, :no_such_thread} = get_thread(category, thread.id)
  end

  # test "list_threads/1 returns all threads", %{category: category, user: user} do
  #   thread = fixture(:thread, category, user, @create_thread_attrs)
  #   expected = [thread.title]
  #
  #   result =
  #     category
  #     |> Forums.list_threads()
  #     |> Enum.map(& &1.title)
  #
  #   assert expected == result
  # end
  #
  # test "recent_threads/1 returns a category's threads ordered by most recent post", %{
  #   category: category,
  #   user: user
  # } do
  #   threads =
  #     for num <- ~w(First Second Third Fourth Fifth) do
  #       fixture(:thread, category, user, %{title: "#{num} thread", body: "#{num} thread body"})
  #     end
  #
  #   for thread <- threads do
  #     for n <- [2, 3, 4] do
  #       fixture(:post, thread, user, %{body: "Post #{n} in #{thread.title}"})
  #     end
  #   end
  #
  #   [thread1, thread2, thread3, thread4, thread5] = threads
  #   :timer.sleep(1)
  #   fixture(:post, thread1, user, %{body: "last post in thread1"})
  #   fixture(:post, thread3, user, %{body: "last post in thread2"})
  #   fixture(:post, thread5, user, %{body: "last post in thread3"})
  #   other_category = fixture(:category, %{title: "other category"})
  #
  #   other_thread =
  #     fixture(:thread, other_category, user, %{title: "other thread", body: "other thread body"})
  #
  #   _other_thread_post = fixture(:post, other_thread, user, %{body: "Other thread last post"})
  #
  #   recent_threads =
  #     category
  #     |> Forums.recent_threads()
  #
  #   thread_ids =
  #     recent_threads
  #     |> Enum.map(& &1.id)
  #
  #   expected_ids = [thread5.id, thread3.id, thread1.id, thread4.id, thread2.id]
  #   assert expected_ids == thread_ids
  # end
  #
end
