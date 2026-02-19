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
      <section
        id="ad-slider"
        phx-hook="AdSlider"
        class="ad-slider mb-8"
        aria-label={gettext("Advertisement highlights")}
      >
        <div class="ad-slider__stage">
          <article class="ad-slide is-active" data-ad-slide>
            <p class="ad-slide__kicker">{gettext("Featured Offer")}</p>
            <h3 class="ad-slide__title">{gettext("40% Off First Telemedicine Visit")}</h3>
            <p class="ad-slide__body">
              {gettext(
                "Start your care journey with faster booking and lower first-visit costs this month."
              )}
            </p>
          </article>

          <article class="ad-slide" data-ad-slide>
            <p class="ad-slide__kicker">{gettext("Family Plan")}</p>
            <h3 class="ad-slide__title">{gettext("Group Appointments In One Dashboard")}</h3>
            <p class="ad-slide__body">
              {gettext("Coordinate follow-ups for your family and receive reminders in one place.")}
            </p>
          </article>

          <article class="ad-slide" data-ad-slide>
            <p class="ad-slide__kicker">{gettext("New Clinics")}</p>
            <h3 class="ad-slide__title">{gettext("Expanded Weekend Availability")}</h3>
            <p class="ad-slide__body">
              {gettext("Find nearby clinics with evening and weekend telemedicine slots.")}
            </p>
          </article>

          <article class="ad-slide" data-ad-slide>
            <p class="ad-slide__kicker">{gettext("Priority Support")}</p>
            <h3 class="ad-slide__title">{gettext("Bilingual Care Team On Standby")}</h3>
            <p class="ad-slide__body">
              {gettext("Get booking help in Korean or English from our patient support specialists.")}
            </p>
          </article>
        </div>

        <div class="ad-slider__meta">
          <div class="ad-slider__controls">
            <button
              type="button"
              class="ad-slider__btn"
              data-ad-dir="prev"
              aria-label={gettext("Previous ad")}
            >
              <.icon name="hero-chevron-left" class="size-4" />
            </button>
            <button
              type="button"
              class="ad-slider__btn"
              data-ad-dir="next"
              aria-label={gettext("Next ad")}
            >
              <.icon name="hero-chevron-right" class="size-4" />
            </button>
          </div>
        </div>

        <div class="ad-slider__dots" aria-hidden="true">
          <span class="ad-dot is-active" data-ad-dot></span>
          <span class="ad-dot" data-ad-dot></span>
          <span class="ad-dot" data-ad-dot></span>
          <span class="ad-dot" data-ad-dot></span>
        </div>
      </section>

      <section class="rounded-2xl bg-gradient-to-br from-slate-50 via-white to-emerald-50 p-6 shadow-sm ring-1 ring-slate-200 sm:p-10">
        <h2 class="text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">
          {gettext("Did Medigrant help you?")}
        </h2>
        <p class="mt-4 max-w-2xl text-base text-slate-700">
          {gettext("We take care of our patients with reliable booking, reminders, and support.")}
        </p>
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
