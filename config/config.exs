import Config

config :medigrant,
  ecto_repos: [Medigrant.Repo],
  generators: [timestamp_type: :utc_datetime],
  see_you_doc_client: Medigrant.SeeYouDocHTTP

config :gettext, :default_locale, "ko"

config :medigrant, MedigrantWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: MedigrantWeb.ErrorHTML, json: MedigrantWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Medigrant.PubSub,
  live_view: [signing_salt: "kVOSTDUe"]

config :esbuild,
  version: "0.25.4",
  medigrant: [
    args:
      ~w(js/app.js --bundle --target=es2022 --outdir=../priv/static/assets/js --external:/fonts/* --external:/images/* --alias:@=.),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => [Path.expand("../deps", __DIR__), Mix.Project.build_path()]}
  ]

config :tailwind,
  version: "4.1.12",
  medigrant: [
    args: ~w(
      --input=assets/css/app.css
      --output=priv/static/assets/css/app.css
    ),
    cd: Path.expand("..", __DIR__)
  ]

config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
