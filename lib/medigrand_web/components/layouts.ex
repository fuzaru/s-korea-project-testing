defmodule MedigrandWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use MedigrandWeb, :html

  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :locale, :string, default: "ko"
  attr :current_path, :string, default: "/"

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <div class="min-h-screen">
      <header class="sticky top-0 z-10 border-b border-slate-200/80 bg-green/600 backdrop-blur">
        <div class="border-b border-slate-200/70">
          <div class="mx-auto flex max-w-6xl items-center justify-between px-4 py-3 sm:px-6">
            <nav class="hidden items-center gap-6 text-sm font-medium text-slate-700 sm:flex">
              <a href={~p"/"}>{gettext("+82 28610902")}</a>
              <a href={~p"/"}>{gettext("support@medigrant.com")}</a>
            </nav>
            <nav class="inline-flex items-center gap-1.5 rounded-full border border-slate-200 bg-slate-100 p-0.5 text-xs">
              <a
                href={locale_path(@current_path, "ko")}
                class={[
                  "rounded-full px-2.5 py-1 transition",
                  @locale == "ko" && "bg-white font-semibold text-slate-900 shadow-sm"
                ]}
              >
                {gettext("한국어")}
              </a>
              <a
                href={locale_path(@current_path, "en")}
                class={[
                  "rounded-full px-2.5 py-1 transition",
                  @locale == "en" && "bg-white font-semibold text-slate-900 shadow-sm"
                ]}
              >
                {gettext("English")}
              </a>
            </nav>
          </div>
        </div>
        <div class="relative mx-auto flex max-w-6xl items-center justify-between px-4 py-3 sm:px-6">
          <a href={~p"/"} class="inline-flex items-center gap-2">
            <img src={~p"/images/logo.svg"} width="30" alt={gettext("Medigrant logo")} />
            <span class="text-lg font-bold tracking-tight">{gettext("Medigrant")}</span>
          </a>

          <nav class="hidden absolute left-1/2 -translate-x-1/2 items-center justify-center gap-3 sm:flex">
            <a
              href={~p"/"}
              class="inline-flex items-center rounded-md px-6 py-1.5 text-sm font-medium text-slate-900 transition hover:bg-emerald-300 hover:text-white"
            >
              {gettext("HOME")}
            </a>
            <a
              href={~p"/"}
              class="inline-flex items-center rounded-md px-6 py-1.5 text-sm font-medium text-slate-900 transition hover:bg-emerald-300 hover:text-white"
            >
              {gettext("DOCTORS")}
            </a>
            <div class="group relative">
              <button
                type="button"
                class="inline-flex items-center rounded-md gap-1 px-6 py-1.5 text-sm font-medium text-slate-900 transition hover:bg-emerald-300 hover:text-white"
              >
                {gettext("SERVICES")}
                <.icon name="hero-chevron-down" class="size-4" />
              </button>
              <div class="absolute left-0 top-full mt-2 hidden w-56 shadow-lg ring-1 ring-slate-200/60 group-hover:block group-focus-within:block">
                <a
                  href={~p"/"}
                  class="block border-b border-slate-200 px-6 py-2 text-sm text-slate-900 transition hover:bg-emerald-300 hover:text-white"
                >
                  {gettext("CONSULTATIONS")}
                </a>
                <a
                  href={~p"/"}
                  class="block border-b border-slate-200 px-6 py-2 text-sm text-slate-900 transition hover:bg-emerald-300 hover:text-white"
                >
                  {gettext("CARE PROGRAMS")}
                </a>
                <a
                  href={~p"/"}
                  class="block px-6 py-2 text-sm text-slate-900 transition hover:bg-emerald-300 hover:text-white"
                >
                  {gettext("TELEMEDICINE")}
                </a>
              </div>
            </div>
            <div class="group relative">
              <button
                type="button"
                class="inline-flex items-center rounded-md gap-1 px-6 py-1.5 text-sm font-medium text-slate-900 transition hover:bg-emerald-300 hover:text-white"
              >
                {gettext("RESOURCES")}
                <.icon name="hero-chevron-down" class="size-4" />
              </button>
              <div class="absolute left-0 rounded-md top-full mt-2 hidden w-56 shadow-lg ring-1 ring-slate-200/60 group-hover:block group-focus-within:block">
                <a
                  href={~p"/"}
                  class="block border-b border-slate-200 px-6 py-2 text-sm text-slate-900 transition hover:bg-emerald-300 hover:text-white"
                >
                  {gettext("BLOG")}
                </a>
                <a
                  href={~p"/"}
                  class="block border-b border-slate-200 px-6 py-2 text-sm text-slate-900 transition hover:bg-emerald-300 hover:text-white"
                >
                  {gettext("GUIDES")}
                </a>
                <a
                  href={~p"/"}
                  class="block px-6 py-2 text-sm text-slate-900 transition hover:bg-emerald-300 hover:text-white"
                >
                  {gettext("FAQ")}
                </a>
              </div>
            </div>
            <a
              href={~p"/"}
              class="inline-flex items-center rounded-md px-6 py-1.5 text-sm font-medium text-slate-900 transition hover:bg-emerald-300 hover:text-white"
            >
              {gettext("ABOUT")}
            </a>
          </nav>

          <a
            href={~p"/"}
            class="inline-flex items-center rounded-full border border-black px-6 py-2 text-sm font-semibold text-slate-900 transition hover:bg-emerald-300 hover:text-white"
          >
            {gettext("Get Started")}
          </a>
        </div>
      </header>

      <section
        :if={home_path?(@current_path)}
        id="hero-slider"
        phx-hook="HeroSlider"
        class="hero-slider border-b border-slate-200/70"
        aria-label={gettext("Featured highlights")}
      >
        <div class="mx-auto grid max-w-6xl gap-6 px-4 py-10 sm:px-6 md:grid-cols-[1.2fr_0.8fr] md:items-center">
          <div class="hero-slider__content">
            <article class="hero-slide is-active" data-slide>
              <p class="hero-slide__eyebrow">{gettext("Care Coordination")}</p>
              <h1 class="hero-slide__title">{gettext("One Platform For Better Patient Access")}</h1>
              <p class="hero-slide__body">
                {gettext(
                  "Handle multilingual bookings, reminders, and telemedicine visits from a single workflow."
                )}
              </p>
            </article>
            <article class="hero-slide" data-slide>
              <p class="hero-slide__eyebrow">{gettext("Clinic Productivity")}</p>
              <h1 class="hero-slide__title">{gettext("Reduce Front Desk Admin Overhead")}</h1>
              <p class="hero-slide__body">
                {gettext(
                  "Automate repetitive intake and scheduling tasks so staff can focus on patients."
                )}
              </p>
            </article>
            <article class="hero-slide" data-slide>
              <p class="hero-slide__eyebrow">{gettext("Clinical Insights")}</p>
              <h1 class="hero-slide__title">{gettext("Monitor Trends And Improve Outcomes")}</h1>
              <p class="hero-slide__body">
                {gettext(
                  "Track appointment demand, follow-up rates, and service performance in real time."
                )}
              </p>
            </article>
          </div>

          <div class="hero-slider__panel">
            <p class="hero-slider__panel-kicker">{gettext("Trusted by growing clinics")}</p>
            <p class="hero-slider__panel-copy">
              {gettext("Built for bilingual patient journeys and operational consistency.")}
            </p>
            <div class="hero-slider__controls">
              <button
                type="button"
                class="hero-slider__btn"
                data-dir="prev"
                aria-label={gettext("Previous slide")}
              >
                <.icon name="hero-chevron-left" class="size-4" />
              </button>
              <button
                type="button"
                class="hero-slider__btn"
                data-dir="next"
                aria-label={gettext("Next slide")}
              >
                <.icon name="hero-chevron-right" class="size-4" />
              </button>
            </div>
            <div class="hero-slider__dots" aria-hidden="true">
              <span class="hero-dot is-active" data-dot></span>
              <span class="hero-dot" data-dot></span>
              <span class="hero-dot" data-dot></span>
            </div>
          </div>
        </div>
      </section>

      <main class="mx-auto w-full max-w-6xl px-4 py-10 sm:px-6 sm:py-14">
        {render_slot(@inner_block)}
      </main>

      <footer class="border-t border-slate-200 bg-white">
        <div class="mx-auto max-w-6xl px-4 py-6 text-sm text-slate-600 sm:px-6">
          <p>{gettext("Medigrant foundation for bilingual telemedicine booking.")}</p>
        </div>
      </footer>
    </div>

    <.flash_group flash={@flash} />
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  defp decode_query(nil), do: %{}
  defp decode_query(query), do: URI.decode_query(query)

  defp home_path?(current_path) when is_binary(current_path) do
    case URI.parse(current_path).path do
      nil -> true
      "" -> true
      "/" -> true
      _ -> false
    end
  end

  defp locale_path(current_path, locale) when is_binary(current_path) and is_binary(locale) do
    uri = URI.parse(current_path)
    query = uri.query |> decode_query() |> Map.put("lang", locale) |> URI.encode_query()
    uri |> Map.put(:query, query) |> URI.to_string()
  end
end
