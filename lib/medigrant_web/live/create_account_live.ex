defmodule MedigrantWeb.CreateAccountLive do
  @moduledoc """
  Account creation page for Medigrant users.
  """
  use MedigrantWeb, :live_view

  alias Medigrant.Accounts
  alias Medigrant.Accounts.Patient

  @impl true
  def mount(_params, _session, socket) do
    changeset = Patient.changeset(%Patient{}, %{country_code: "+82"})

    {:ok,
     socket
     |> assign(:form, to_form(changeset))
     |> assign_new(:current_path, fn -> ~p"/create-account" end)}
  end

  @impl true
  def handle_params(_params, uri, socket) do
    {:noreply, assign(socket, :current_path, path_with_query(uri))}
  end

  @impl true
  def handle_event("validate", %{"patient" => params}, socket) do
    changeset =
      %Patient{}
      |> Patient.changeset(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end

  @impl true
  def handle_event("save", %{"patient" => params}, socket) do
    case Accounts.create_patient(params) do
      {:ok, _patient} ->
        {:noreply,
         socket
         |> put_flash(:info, gettext("Account created. Please log in."))
         |> push_navigate(to: ~p"/login")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} locale={@locale} current_path={@current_path} minimal_nav={true}>
      <section class="ml-auto mr-0 max-w-md rounded-2xl bg-white p-6 shadow-sm ring-1 ring-slate-200 sm:p-8">
        <h1 class="text-2xl font-bold tracking-tight text-center text-slate-900">
          {gettext("Create Account")}
        </h1>
        <p class="mt-2 text-sm text-justify text-slate-600">
          {gettext("Set up your profile to start booking and managing appointments.")}
        </p>

        <.form for={@form} phx-change="validate" phx-submit="save" class="mt-6 space-y-4">
          <label class="block">
            <span class="mb-1 block text-sm font-medium text-slate-700">{gettext("Email")}</span>
            <input
              type="email"
              name={@form[:email].name}
              value={@form[:email].value}
              class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-900 placeholder:text-slate-500 outline-none transition focus:border-emerald-500"
              placeholder={gettext("you@example.com")}
            />
            <p
              :for={msg <- translate_errors(@form.errors, :email)}
              class="mt-1 text-sm text-red-600"
            >
              {msg}
            </p>
          </label>

          <label class="block">
            <span class="mb-1 block text-sm font-medium text-slate-700">
              {gettext("Mobile Number")}
            </span>

            <div class="flex gap-2">
              <select
                class="w-28 rounded-xl border border-slate-300 bg-white px-2 py-2 text-sm text-slate-900 outline-none focus:border-emerald-500"
                name={@form[:country_code].name}
              >
                <option value="+82" selected={@form[:country_code].value == "+82"}>🇰🇷 +82</option>
                <option value="+1" selected={@form[:country_code].value == "+1"}>🇺🇸 +1</option>
                <option value="+81" selected={@form[:country_code].value == "+81"}>🇯🇵 +81</option>
              </select>

              <input
                type="tel"
                name={@form[:mobile_number].name}
                value={@form[:mobile_number].value}
                class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-900 placeholder:text-slate-500 outline-none transition focus:border-emerald-500"
                placeholder={gettext("1234-5678")}
              />
            </div>
            <p
              :for={msg <- translate_errors(@form.errors, :country_code)}
              class="mt-1 text-sm text-red-600"
            >
              {msg}
            </p>
            <p
              :for={msg <- translate_errors(@form.errors, :mobile_number)}
              class="mt-1 text-sm text-red-600"
            >
              {msg}
            </p>
          </label>

          <label class="block">
            <span class="mb-1 block text-sm font-medium text-slate-700">{gettext("Password")}</span>
            <input
              type="password"
              name={@form[:password].name}
              class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-900 placeholder:text-slate-500 outline-none transition focus:border-emerald-500"
              placeholder="********"
            />
            <p
              :for={msg <- translate_errors(@form.errors, :password)}
              class="mt-1 text-sm text-red-600"
            >
              {msg}
            </p>
          </label>

          <label class="block">
            <span class="mb-1 block text-sm font-medium text-slate-700">{gettext("First Name")}</span>
            <input
              type="text"
              name={@form[:first_name].name}
              value={@form[:first_name].value}
              class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-900 placeholder:text-slate-500 outline-none transition focus:border-emerald-500"
              placeholder={gettext("First Name")}
            />
            <p
              :for={msg <- translate_errors(@form.errors, :first_name)}
              class="mt-1 text-sm text-red-600"
            >
              {msg}
            </p>
          </label>

          <label class="block">
            <span class="mb-1 block text-sm font-medium text-slate-700">{gettext("Last Name")}</span>
            <input
              type="text"
              name={@form[:last_name].name}
              value={@form[:last_name].value}
              class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-900 placeholder:text-slate-500 outline-none transition focus:border-emerald-500"
              placeholder={gettext("Last Name")}
            />
            <p
              :for={msg <- translate_errors(@form.errors, :last_name)}
              class="mt-1 text-sm text-red-600"
            >
              {msg}
            </p>
          </label>

          <label class="block">
            <span class="mb-1 block text-sm font-medium text-slate-700">
              {gettext("Date of Birth")}
            </span>
            <input
              type="date"
              name={@form[:date_of_birth].name}
              value={@form[:date_of_birth].value}
              class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-900 outline-none transition focus:border-emerald-500"
            />
            <p
              :for={msg <- translate_errors(@form.errors, :date_of_birth)}
              class="mt-1 text-sm text-red-600"
            >
              {msg}
            </p>
          </label>

          <label class="block">
            <span class="mb-1 block text-sm font-medium text-slate-700">
              {gettext("Sex")}
            </span>
            <select
              class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-900 outline-none focus:border-emerald-500"
              name={@form[:sex].name}
            >
              <option value="female" selected={@form[:sex].value == "female"}>
                {gettext("Female")}
              </option>
              <option value="male" selected={@form[:sex].value == "male"}>
                {gettext("Male")}
              </option>
              <option value="other" selected={@form[:sex].value == "other"}>
                {gettext("Other")}
              </option>
            </select>
            <p
              :for={msg <- translate_errors(@form.errors, :sex)}
              class="mt-1 text-sm text-red-600"
            >
              {msg}
            </p>
          </label>

          <button
            type="submit"
            class="mt-2 inline-flex w-full items-center justify-center rounded-xl border border-black px-4 py-2 text-sm font-semibold text-slate-900 transition hover:bg-emerald-300 hover:text-white"
          >
            {gettext("Create Account")}
          </button>
        </.form>

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
