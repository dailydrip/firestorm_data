defmodule FirestormData.Factory do
  use ExMachina.Ecto, repo: FirestormData.Repo

  alias FirestormData.{
    Users.User,
    Categories.Category,
    Threads.Thread
  }

  def user_factory do
    %User{
      name: Faker.Name.name(),
      email: sequence(:email, &"email-#{&1}@example.com"),
      username: Faker.Internet.user_name(),
      api_token: UUID.uuid4()
    }
  end

  def category_factory do
    %Category{
      title: Faker.Lorem.sentence(),
      slug: Faker.Internet.slug()
    }
  end

  def thread_factory do
    %Thread{
      title: Faker.Lorem.sentence(),
      category: insert(:category),
      user: insert(:user)
    }
  end
end
