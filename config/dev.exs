import Config

db_user = System.get_env("DB_USER", "postgres")
db_pass = System.get_env("DB_PASS", "postgres")
db_host = System.get_env("DB_HOST", "localhost")
db_port = String.to_integer(System.get_env("DB_PORT", "5432"))
db_name = System.get_env("DB_NAME", "medigrand_dev")

config :medigrand, Medigrand.Repo,
  username: db_user,
  password: db_pass,
  hostname: db_host,
  port: db_port,
  database: db_name,
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :medigrand, MedigrandWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "2mNhOY5jjW+etVkcMLajCHHMn2WPiO8JumxEIX8verUyAlVuyowkiyI44bWqlW1/",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:medigrand, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:medigrand, ~w(--watch)]}
  ]

config :medigrand, MedigrandWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  live_reload: [
    web_console_logger: true,
    patterns: [
      ~r"priv/static/(?!uploads/).*\.(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*\.po$",
      ~r"lib/medigrand_web/router\.ex$",
      ~r"lib/medigrand_web/(controllers|live|components)/.*\.(ex|heex)$"
    ]
  ]

config :medigrand, dev_routes: true

config :logger, :default_formatter, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  debug_heex_annotations: true,
  debug_attributes: true,
  enable_expensive_runtime_checks: true
