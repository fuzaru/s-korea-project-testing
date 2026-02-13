import Config

test_db_user = System.get_env("TEST_DB_USER", System.get_env("DB_USER", "postgres"))
test_db_pass = System.get_env("TEST_DB_PASS", System.get_env("DB_PASS", "postgres"))
test_db_host = System.get_env("TEST_DB_HOST", System.get_env("DB_HOST", "localhost"))

test_db_port =
  String.to_integer(System.get_env("TEST_DB_PORT", System.get_env("DB_PORT", "5432")))

test_db_name = System.get_env("TEST_DB_NAME", "medigrand_test")

config :medigrand, Medigrand.Repo,
  username: test_db_user,
  password: test_db_pass,
  hostname: test_db_host,
  port: test_db_port,
  database: "#{test_db_name}#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

config :medigrand, MedigrandWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "sCV+3lr52G8WzYsYQBJvZHixJfMd3nHQYjw27WZvuC2duIvs831ODoRg38LBK5cX",
  server: false

config :logger, level: :warning

config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  enable_expensive_runtime_checks: true

config :phoenix,
  sort_verified_routes_query_params: true
