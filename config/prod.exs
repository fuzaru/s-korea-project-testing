import Config

config :medigrand, MedigrandWeb.Endpoint, cache_static_manifest: "priv/static/cache_manifest.json"

config :medigrand, MedigrandWeb.Endpoint,
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  exclude: [
    hosts: ["localhost", "127.0.0.1"]
  ]

config :logger, level: :info
