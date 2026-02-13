defmodule MedigrandWeb.Live.LocaleHook do
  @moduledoc """
  LiveView on_mount hook to apply locale from params/session.
  """
  use MedigrandWeb, :verified_routes
  import Phoenix.Component

  @available_locales ~w(ko en)
  @default_locale "ko"

  def on_mount(:default, params, session, socket) do
    locale =
      params["lang"]
      |> normalize_locale(session["locale"])

    Gettext.put_locale(MedigrandWeb.Gettext, locale)

    socket =
      socket
      |> assign(:locale, locale)
      |> assign_new(:current_path, fn -> ~p"/" end)

    {:cont, socket}
  end

  defp normalize_locale(locale, _) when locale in @available_locales, do: locale

  defp normalize_locale(_, session_locale) when session_locale in @available_locales,
    do: session_locale

  defp normalize_locale(_, _), do: @default_locale
end
