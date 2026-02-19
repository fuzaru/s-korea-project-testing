defmodule MedigrandWeb.Router do
  use MedigrandWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug MedigrandWeb.Plugs.Locale
    plug :put_root_layout, html: {MedigrandWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MedigrandWeb do
    pipe_through :browser

    live_session :default, on_mount: [MedigrandWeb.Live.LocaleHook] do
      live "/", LandingLive, :index
      live "/login", LoginLive, :index
      live "/create-account", CreateAccountLive, :index
    end

    get "/health", HealthController, :index
  end

  if Application.compile_env(:medigrand, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MedigrandWeb.Telemetry
    end
  end
end
