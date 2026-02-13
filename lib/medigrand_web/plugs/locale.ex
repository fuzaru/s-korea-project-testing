defmodule MedigrandWeb.Plugs.Locale do
  @moduledoc """
  Sets and persists locale from query params or session.
  """
  import Plug.Conn

  @available_locales ~w(ko en)
  @default_locale "ko"

  def init(opts), do: opts

  def call(conn, _opts) do
    requested_locale = conn.params["lang"] || get_session(conn, :locale)
    locale = normalize_locale(requested_locale)

    Gettext.put_locale(MedigrandWeb.Gettext, locale)

    conn
    |> put_session(:locale, locale)
    |> assign(:locale, locale)
    |> assign(:current_path, request_path_with_query(conn))
  end

  defp normalize_locale(locale) when locale in @available_locales, do: locale
  defp normalize_locale(_), do: @default_locale

  defp request_path_with_query(conn) do
    case conn.query_string do
      "" -> conn.request_path
      query -> "#{conn.request_path}?#{query}"
    end
  end
end
