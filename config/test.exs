use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :platform, PlatformWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :bcrypt_elixir, :log_rounds, 4

# Configure your database
config :platform, Platform.Repo,
  username: "postgres",
  password: "Nautica",
  database: "platform_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
