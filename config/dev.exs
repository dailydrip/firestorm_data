use Mix.Config

# Configure your database
config :firestorm_data, FirestormData.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "firestorm_dev",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  pool_size: 10
