defmodule FirestormData.Factory do
  use ExMachina.Ecto, repo: FirestormData.Repo

  alias FirestormData.{
    Users.User
  }

  def user_factory do
    %User{
      name: Faker.Name.name(),
      email: sequence(:email, &"email-#{&1}@example.com"),
      username: Faker.Internet.user_name()
    }
  end
end
