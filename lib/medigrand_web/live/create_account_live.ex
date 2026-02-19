defmodule MedigrandWeb.CreateAccountLive do
  @moduledoc """
  Account creation page for Medigrant users.
  """
  use MedigrandWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign_new(socket, :current_path, fn -> ~p"/create-account" end)}
  end

  @impl true
  def handle_params(_params, uri, socket) do
    {:noreply, assign(socket, :current_path, path_with_query(uri))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} locale={@locale} current_path={@current_path}>
      <section class="mx-auto max-w-md rounded-2xl bg-white p-6 shadow-sm ring-1 ring-slate-200 sm:p-8">
        <h1 class="text-2xl font-bold tracking-tight text-slate-900">{gettext("Create Account")}</h1>
        <p class="mt-2 text-sm text-slate-600">
          {gettext("Set up your profile to start booking and managing appointments.")}
        </p>

        <form class="mt-6 space-y-4">
          <label class="block">
            <span class="mb-1 block text-sm font-medium text-slate-700">{gettext("Full Name")}</span>
            <input
              type="text"
              class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-900 outline-none transition focus:border-emerald-500"
              placeholder={gettext("Your name")}
            />
          </label>

          <label class="block">
            <span class="mb-1 block text-sm font-medium text-slate-700">{gettext("Email")}</span>
            <input
              type="email"
              class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-900 outline-none transition focus:border-emerald-500"
              placeholder={gettext("you@example.com")}
            />
          </label>

          <label class="block">
            <span class="mb-1 block text-sm font-medium text-slate-700">{gettext("Password")}</span>
            <input
              type="password"
              class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-900 outline-none transition focus:border-emerald-500"
              placeholder="********"
            />
          </label>

          <button
            type="button"
            class="mt-2 inline-flex w-full items-center justify-center rounded-xl border border-black px-4 py-2 text-sm font-semibold text-slate-900 transition hover:bg-emerald-300 hover:text-white"
          >
            {gettext("Create Account")}
          </button>
        </form>

        <p class="mt-4 text-center text-sm text-slate-600">
          {gettext("Already have an account?")}
          <a href={~p"/login"} class="font-semibold text-slate-900 hover:text-emerald-700">
            {gettext("Log In")}
          </a>
        </p>
      </section>
    </Layouts.app>
    """
  end

  defp path_with_query(uri) do
    parsed = URI.parse(uri)

    case parsed.query do
      nil -> parsed.path || "/create-account"
      query -> "#{parsed.path}?#{query}"
    end
  end
end
