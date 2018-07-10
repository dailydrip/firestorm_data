defmodule FirestormData.Factory do
  use ExMachina.Ecto, repo: FirestormData.Repo

  alias FirestormData.{
    Users.User,
    Categories.Category
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
end
