# Dev Guide

This guide explains what the main files/folders are for, and what to do every day while developing this project.

## 1. Mental Model

- `lib/` = application code.
- `lib/medigrand/` = business/domain code (accounts, bookings, catalog, API adapter).
- `lib/medigrand_web/` = web layer (router, controllers, LiveView, components).
- `test/` = tests.
- `config/` = environment configuration (`dev`, `test`, `prod`, runtime).
- `assets/` = frontend CSS/JS build inputs.
- `priv/` = runtime resources (translations, DB seeds, static files).
- `mix.exs` = project definition, dependencies, task aliases.
- `docker-compose.yml` = local PostgreSQL container.
- `.env` / `.env.example` = environment variables for DB and runtime values.

## 2. Important Files And What They Do

- `mix.exs`: dependency versions, aliases like `mix setup`, `mix quality`, `mix precommit`.
- `config/dev.exs`: dev database and dev-only behavior.
- `config/test.exs`: test database configuration.
- `config/runtime.exs`: runtime config loaded when app boots.
- `lib/medigrand/application.ex`: starts supervised processes for the app.
- `lib/medigrand/repo.ex`: Ecto Repo (database access entrypoint).
- `lib/medigrand_web/router.ex`: routes (`/`, `/health`, browser pipeline).
- `lib/medigrand_web/endpoint.ex`: HTTP endpoint setup and plugs.
- `lib/medigrand_web/live/landing_live.ex`: landing page LiveView.
- `lib/medigrand_web/plugs/locale.ex`: locale (`ko`/`en`) selection.
- `test/support/conn_case.ex`: setup helpers for controller/HTTP tests.
- `test/support/data_case.ex`: setup helpers for DB tests (SQL sandbox).
- `priv/repo/seeds.exs`: seed data script run by `mix ecto.setup`.
- `README.md`: setup instructions and team-level notes.

## 3. Daily Development Workflow

1. Open terminal in project root.
2. Load env vars:

```bash
set -a; source .env; set +a
```

3. Ensure DB is running:

```bash
docker compose up -d db
```

4. Start Phoenix server:

```bash
mix phx.server
```

5. In another terminal (also load `.env`), run tests while coding:

```bash
mix test
```

6. Before commit, run quality checks:

```bash
mix quality
mix dialyzer
```

7. Final pre-push check:

```bash
mix precommit
```

## 4. First-Time Setup (Only Once Per Machine)

```bash
cp .env.example .env
set -a; source .env; set +a
docker compose up -d db
mix deps.get
mix setup
mix phx.server
```

Health check:

```bash
curl -i http://localhost:4000/health
```

Expected: HTTP `200` with body `ok`.

## 5. Common Commands Cheat Sheet

- Run app: `mix phx.server`
- Run tests: `mix test`
- Lint: `mix credo` / `mix credo --strict`
- Type checks: `mix dialyzer`
- Docs: `mix docs`
- Full CI-style local checks: `mix precommit`

## 6. If Something Breaks

- DB auth errors: recreate DB volume:

```bash
docker compose down -v
docker compose up -d db
mix ecto.setup
```

- Build issues after dependency changes:

```bash
mix deps.get
mix compile
```
