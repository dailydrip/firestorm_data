use Mix.Config

# Configure your database
config :firestorm_data, FirestormData.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "firestorm_test",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  ownership_timeout: 30_000

# Print only warnings and errors during test
config :logger, level: :warn
