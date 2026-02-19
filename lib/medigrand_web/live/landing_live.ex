defmodule MedigrandWeb.LandingLive do
  @moduledoc """
  Public landing page for Medigrant.
  """
  use MedigrandWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign_new(socket, :current_path, fn -> ~p"/" end)}
  end

  @impl true
  def handle_params(_params, uri, socket) do
    {:noreply, assign(socket, :current_path, path_with_query(uri))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} locale={@locale} current_path={@current_path}>
      <section class="rounded-2xl bg-gradient-to-br from-slate-50 via-white to-emerald-50 p-6 shadow-sm ring-1 ring-slate-200 sm:p-10">
        <p class="text-sm font-semibold tracking-wide text-emerald-700">
          {gettext("Trusted telemedicine booking for clinics and hospitals")}
        </p>
        <h1 class="mt-3 text-3xl font-bold tracking-tight text-slate-900 sm:text-4xl">
          {gettext("Medigrant")}
        </h1>
        <p class="mt-4 max-w-2xl text-base text-slate-700">
          {gettext("Korean-first scheduling foundation for white-label telemedicine portals.")}
        </p>

        <div class="mt-8 flex flex-col gap-3 sm:flex-row">
          <a
            href="#"
            class="inline-flex items-center justify-center rounded-lg bg-emerald-600 px-4 py-2 font-semibold text-white transition hover:bg-emerald-500"
          >
            {gettext("Start booking flow")}
          </a>
          <a
            href="#"
            class="inline-flex items-center justify-center rounded-lg border border-slate-300 bg-white px-4 py-2 font-semibold text-slate-800 transition hover:bg-slate-50"
          >
            {gettext("Browse doctors")}
          </a>
        </div>
      </section>
      <section class="mt-8 grid gap-3 sm:grid-cols-1 lg:grid-cols-3">
        <article class="relative rounded-xl bg-gradient-to-br from-emerald-50 to-emerald-100 p-5 pr-16 ring-2 ring-emerald-200 min-h-[320px]">
          <h3 class="text-5xl font-semibold text-black">“</h3>
          <p class="mt-4 text-sm text-slate-700 text-justify">
            {gettext("Great experience overall. The process felt simple and stress-free.")}
          </p>
          <a
            href="#"
            class="absolute bottom-5 left-5 inline-block h-10 w-10 rounded-full border-2 border-black"
            aria-hidden="true"
          >
          </a>
        </article>

        <article class="relative rounded-xl bg-gradient-to-br from-emerald-50 to-emerald-100 p-5 pr-16 ring-2 ring-emerald-200 min-h-[320px]">
          <h3 class="text-5xl font-semibold text-black">“</h3>
          <p class="mt-4 text-sm text-slate-700 text-justify">
            {gettext(
              "This platform made booking so easy, and the reminders helped me never miss an appointment."
            )}
          </p>
          <a
            href="#"
            class="absolute bottom-5 left-5 inline-block h-10 w-10 rounded-full border-2 border-black"
            aria-hidden="true"
          >
          </a>
        </article>

        <article class="relative rounded-xl bg-gradient-to-br from-emerald-50 to-emerald-100 p-5 pr-16 ring-2 ring-emerald-200 min-h-[320px]">
          <h3 class="text-5xl font-semibold text-black">“</h3>
          <p class="mt-4 text-sm text-slate-700 text-justify">
            {gettext("I was able to find a doctor quickly and book in less than five minutes.")}
          </p>

          <a
            href="#"
            class="absolute bottom-5 left-5 inline-block h-10 w-10 rounded-full border-2 border-black"
            aria-hidden="true"
          >
          </a>
        </article>
      </section>
    </Layouts.app>
    """
  end

  defp path_with_query(uri) do
    parsed = URI.parse(uri)

    case parsed.query do
      nil -> parsed.path || "/"
      query -> "#{parsed.path}?#{query}"
    end
  end
end
