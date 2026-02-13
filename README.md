# Medigrand Foundation (Phoenix)

Foundation for a bilingual (Korean primary, English secondary) telemedicine booking site.

Dev guide: `DEVELOPER_GUIDE.md` - explanation of files and daily workflow.

## Stack

- Elixir + Phoenix 1.8 + LiveView
- Tailwind CSS + esbuild
- PostgreSQL + Ecto
- Gettext (`ko`, `en`)

## Fresh Machine Setup (Step-by-Step)

Use this when you clone the repo on a brand-new machine.

1. Install prerequisites: `git`, `docker`, `docker compose`, Elixir/Erlang.
2. Enter the project directory.

```bash
cd s-korea-project-testing
```

3. Create local env file.

```bash
cp .env.example .env
```

4. Load env vars in your shell.

```bash
set -a; source .env; set +a
```

5. Start PostgreSQL container.

```bash
docker compose up -d db
```

6. Install dependencies and initialize app/database.

```bash
mix deps.get
mix setup
```

7. Start the server.

```bash
mix phx.server
```

8. Verify app is running.

```bash
curl -i http://localhost:4000/health
```

Expected result: HTTP `200` and body `ok`.

Default Docker DB port is `5433` (to avoid conflict with local PostgreSQL on `5432`).

## Daily Dev Commands

```bash
set -a; source .env; set +a
mix phx.server
```

In another terminal:

```bash
set -a; source .env; set +a
mix test
```

## Quality Tooling (Installed In Repo)

Project-local tooling is installed and versioned in `mix.exs`:

- `credo` for static code analysis
- `dialyxir` for Dialyzer integration
- `ex_doc` for docs generation

Commands:

```bash
mix credo
mix credo --strict
mix dialyzer
mix docs
mix quality
mix precommit
```

`mix quality` runs formatting check, compile warnings-as-errors, Credo, and tests.

## Troubleshooting (Team)

### `watchman: not found`

- This is non-blocking in development; Phoenix still runs.
- Optional install on Ubuntu:

```bash
sudo apt install watchman
```

### `password authentication failed for user "postgres"`

This usually means Docker Postgres was initialized earlier with a different password (existing volume state).

1. Ensure env vars are loaded:
   Use steps 3 and 4 from `Fresh Machine Setup (Step-by-Step)`.

2. Recreate Postgres volume and container:

```bash
docker compose down -v
docker compose up -d db
```

3. Verify DB credentials directly:

```bash
PGPASSWORD=$DB_PASS psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d postgres -c "SELECT 1;"
```

4. Re-run project DB setup:

```bash
mix ecto.setup
```

### `Bunt.puts/1 is undefined (module Bunt is not available)` when running `mix credo`

This usually means dependencies are not fully fetched/compiled on that machine.

1. Load env vars:
   Use steps 3 and 4 from `Fresh Machine Setup (Step-by-Step)`.
2. Clean and reinstall deps:

```bash
mix deps.clean --all
mix deps.get
mix deps.compile
```

3. Retry Credo:

```bash
mix credo
```

If it still fails, remove local build artifacts and retry:

```bash
rm -rf _build deps
mix deps.get
mix compile
mix credo
```

## If You Already Have Local PostgreSQL (No Docker)

1. Copy and load env file.
   Use steps 3 and 4 from `Fresh Machine Setup (Step-by-Step)`.

2. If using local PostgreSQL on `5432`, change these in `.env`:

```bash
DB_PORT=5432
TEST_DB_PORT=5432
```

3. Ensure role/db exist and credentials match `.env`.

4. Run setup.

```bash
mix setup
```

5. Start app.

```bash
mix phx.server
```

## Configuration Model

- `config/dev.exs` reads DB values from:
  - `DB_USER`, `DB_PASS`, `DB_HOST`, `DB_PORT`, `DB_NAME`
- `config/test.exs` reads from:
  - `TEST_DB_*` (or falls back to `DB_*`)

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
