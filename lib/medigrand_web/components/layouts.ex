defmodule MedigrandWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use MedigrandWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
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
      <header class="sticky top-0 z-10 border-b border-slate-200/80 bg-white/95 backdrop-blur">
        <div class="border-b border-slate-200/70">
          <div class="mx-auto flex max-w-6xl items-center justify-end px-4 py-1.5 sm:px-6">
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
        <div class="mx-auto flex max-w-6xl items-center justify-between px-4 py-3 sm:px-6">
          <a href={~p"/"} class="inline-flex items-center gap-2">
            <img src={~p"/images/logo.svg"} width="30" alt={gettext("Medigrand logo")} />
            <span class="text-lg font-bold tracking-tight">{gettext("Medigrand")}</span>
          </a>

          <nav class="hidden items-center gap-6 sm:flex">
            <a href={~p"/"} class="text-sm font-medium text-slate-700 hover:text-slate-900">
              {gettext("HOME")}
            </a>
            <a href={~p"/"} class="text-sm font-medium text-slate-700 hover:text-slate-900">
              {gettext("DOCTORS")}
            </a>
            <div class="group relative">
              <button
                type="button"
                class="inline-flex items-center gap-1 text-sm font-medium text-slate-700 hover:text-slate-900"
              >
                {gettext("SERVICES")}
                <.icon name="hero-chevron-down" class="size-4" />
              </button>
              <div class="absolute left-0 top-full mt-2 hidden w-56 rounded-lg border border-slate-200 bg-white shadow-lg ring-1 ring-slate-200/60 group-hover:block group-focus-within:block">
                <a
                  href={~p"/"}
                  class="block px-4 py-2 text-sm text-slate-700 hover:bg-slate-50"
                >
                  {gettext("CONSULTATIONS")}
                </a>
                <a
                  href={~p"/"}
                  class="block px-4 py-2 text-sm text-slate-700 hover:bg-slate-50"
                >
                  {gettext("CARE PROGRAMS")}
                </a>
                <a
                  href={~p"/"}
                  class="block px-4 py-2 text-sm text-slate-700 hover:bg-slate-50"
                >
                  {gettext("TELEMEDICINE")}
                </a>
              </div>
            </div>
            <div class="group relative">
              <button
                type="button"
                class="inline-flex items-center gap-1 text-sm font-medium text-slate-700 hover:text-slate-900"
              >
                {gettext("RESOURCES")}
                <.icon name="hero-chevron-down" class="size-4" />
              </button>
              <div class="absolute left-0 top-full mt-2 hidden w-56 rounded-lg border border-slate-200 bg-white shadow-lg ring-1 ring-slate-200/60 group-hover:block group-focus-within:block">
                <a
                  href={~p"/"}
                  class="block px-4 py-2 text-sm text-slate-700 hover:bg-slate-50"
                >
                  {gettext("BLOG")}
                </a>
                <a
                  href={~p"/"}
                  class="block px-4 py-2 text-sm text-slate-700 hover:bg-slate-50"
                >
                  {gettext("GUIDES")}
                </a>
                <a
                  href={~p"/"}
                  class="block px-4 py-2 text-sm text-slate-700 hover:bg-slate-50"
                >
                  {gettext("FAQ")}
                </a>
              </div>
            </div>
            <a
              href={~p"/"}
              class="text-sm font-medium text-slate-700 hover:text-slate-900"
            >
              {gettext("ABOUT")}
            </a>
            <nav class="inline-flex items-center gap-1.5 rounded-full border border-slate-200 bg-slate-100 p-0.5 text-xs">
              <a
                href={locale_path(@current_path, "ko")}
                class={[
                  "rounded-full px-4 py-1 transition",
                  @locale == "ko" && "bg-white font-semibold text-slate-900 shadow-sm"
                ]}
              >
                {gettext("GET STARTED")}
              </a>
            </nav>
          </nav>
        </div>
      </header>

      <main class="mx-auto w-full max-w-6xl px-4 py-10 sm:px-6 sm:py-14">
        {render_slot(@inner_block)}
      </main>

      <footer class="border-t border-slate-200 bg-white">
        <div class="mx-auto max-w-6xl px-4 py-6 text-sm text-slate-600 sm:px-6">
          <p>{gettext("Medigrand foundation for bilingual telemedicine booking.")}</p>
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

  defp locale_path(current_path, locale) when is_binary(current_path) and is_binary(locale) do
    uri = URI.parse(current_path)
    query = uri.query |> decode_query() |> Map.put("lang", locale) |> URI.encode_query()
    uri |> Map.put(:query, query) |> URI.to_string()
  end
end
