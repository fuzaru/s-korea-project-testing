import Config

test_db_user = System.get_env("TEST_DB_USER", System.get_env("DB_USER", "postgres"))
test_db_pass = System.get_env("TEST_DB_PASS", System.get_env("DB_PASS", "postgres"))
test_db_host = System.get_env("TEST_DB_HOST", System.get_env("DB_HOST", "localhost"))

test_db_port =
  String.to_integer(System.get_env("TEST_DB_PORT", System.get_env("DB_PORT", "5432")))

test_db_name = System.get_env("TEST_DB_NAME", "medigrand_test")

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :medigrand, Medigrand.Repo,
  username: test_db_user,
  password: test_db_pass,
  hostname: test_db_host,
  port: test_db_port,
  database: "#{test_db_name}#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :medigrand, MedigrandWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "sCV+3lr52G8WzYsYQBJvZHixJfMd3nHQYjw27WZvuC2duIvs831ODoRg38LBK5cX",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

# Sort query params output of verified routes for robust url comparisons
config :phoenix,
  sort_verified_routes_query_params: true
