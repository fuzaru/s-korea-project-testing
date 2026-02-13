# Medigrand Foundation (Phoenix)

Foundation for a bilingual (Korean primary, English secondary) telemedicine booking site.

## Stack

- Elixir + Phoenix 1.8 + LiveView
- Tailwind CSS + esbuild
- PostgreSQL + Ecto
- Gettext (`ko`, `en`)

## Prerequisites

- Elixir `~> 1.15` (tested with 1.17.x)
- Erlang/OTP
- PostgreSQL (running locally)

## Setup

```bash
mix deps.get
mix ecto.setup
mix assets.setup
```

## Run server

```bash
mix phx.server
```

Open `http://localhost:4000`.

## Run tests

```bash
mix test
```

## Foundation implemented

- Root route (`/`) served by `MedigrandWeb.LandingLive`
- Health check route (`/health`) returns `ok`
- Locale system:
  - default locale is `ko`
  - toggle UI in header (`한국어` / `English`)
  - query param support: `?lang=ko|en`
  - locale persisted in session
- Mobile-first base layout with header/footer and Korean-friendly font stack
- Context scaffolding:
  - `Medigrand.Accounts`
  - `Medigrand.Catalog`
  - `Medigrand.Bookings`
- External API integration placeholder:
  - `Medigrand.SeeYouDocClient` behaviour
  - `Medigrand.SeeYouDocHTTP` adapter stub (no real endpoints)

## Project structure highlights

- `lib/medigrand_web/live/landing_live.ex`: landing page LiveView
- `lib/medigrand_web/plugs/locale.ex`: browser locale + session persistence
- `lib/medigrand_web/live/locale_hook.ex`: LiveView locale assignment
- `lib/medigrand_web/components/layouts.ex`: header/footer + locale toggle
- `lib/medigrand_web/controllers/health_controller.ex`: uptime endpoint
- `lib/medigrand/{accounts,catalog,bookings}.ex`: context foundations
- `lib/medigrand/{see_you_doc_client,see_you_doc_http}.ex`: API behaviour + adapter stub
- `priv/gettext/{ko,en}/LC_MESSAGES/default.po`: UI translations

## Extending for real REST APIs later

1. Keep `Medigrand.SeeYouDocClient` callbacks as the integration contract.
2. Replace stub bodies in `Medigrand.SeeYouDocHTTP` with `Req` calls.
3. Add request/response mappers per resource (`doctors`, `bookings`, `auth`).
4. Add adapter tests with mocked HTTP, then context integration tests.
5. If needed, create additional adapters and swap with config:

```elixir
config :medigrand, :see_you_doc_client, MyCustomAdapter
```
