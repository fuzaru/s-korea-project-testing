defmodule MedigrandWeb.DoctorsLive do
  @moduledoc """
  Doctors directory page for Medigrant.
  """
  use MedigrandWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    all_doctors = doctors()

    socket =
      socket
      |> assign_new(:current_path, fn -> ~p"/doctors" end)
      |> assign(:specialties, specialties())
      |> assign(:all_doctors, all_doctors)
      |> assign(:doctors, all_doctors)
      |> assign(:selected_specialty, all_specialties_label())

    {:ok, socket}
  end

  @impl true
  def handle_params(_params, uri, socket) do
    {:noreply, assign(socket, :current_path, path_with_query(uri))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} locale={@locale} current_path={@current_path}>
      <section class="mx-auto max-w-6xl px-4 py-10 sm:px-6">
        <div class="grid gap-8 lg:grid-cols-[1.1fr_0.9fr] lg:items-center">
          <div>
            <p class="text-xs font-semibold uppercase tracking-[0.2em] text-emerald-700">
              {gettext("Trusted Specialists")}
            </p>
            <h1 class="mt-3 text-3xl font-bold tracking-tight text-slate-900 sm:text-4xl">
              {gettext("Meet Our Doctors")}
            </h1>
            <p class="mt-3 max-w-xl text-base text-slate-600">
              {gettext("Book a virtual or in-clinic visit with bilingual specialists.")}
            </p>
            <div class="mt-6 flex flex-wrap gap-2">
              <span class="text-sm font-semibold text-slate-700">
                {gettext("Search by specialty")}
              </span>
              <%= for specialty <- @specialties do %>
                <button
                  type="button"
                  phx-click="filter"
                  phx-value-specialty={specialty}
                  class={[
                    "rounded-full border px-4 py-1.5 text-sm transition",
                    @selected_specialty == specialty &&
                      "border-emerald-400 bg-emerald-50 font-semibold text-emerald-800",
                    @selected_specialty != specialty &&
                      "border-slate-200 bg-white text-slate-600 hover:border-emerald-400 hover:text-emerald-700"
                  ]}
                >
                  {specialty}
                </button>
              <% end %>
            </div>
          </div>
          <div class="rounded-3xl bg-gradient-to-br from-emerald-50 via-white to-slate-100 p-6 shadow-sm ring-1 ring-slate-200">
            <div class="grid gap-4 sm:grid-cols-3">
              <div>
                <p class="text-xs uppercase tracking-widest text-slate-500">
                  {gettext("Available today")}
                </p>
                <p class="mt-2 text-2xl font-semibold text-slate-900">18</p>
              </div>
              <div>
                <p class="text-xs uppercase tracking-widest text-slate-500">
                  {gettext("Patients this week")}
                </p>
                <p class="mt-2 text-2xl font-semibold text-slate-900">326</p>
              </div>
              <div>
                <p class="text-xs uppercase tracking-widest text-slate-500">
                  {gettext("Avg. rating")}
                </p>
                <p class="mt-2 text-2xl font-semibold text-slate-900">4.8</p>
              </div>
            </div>
            <div class="mt-6 grid gap-4 rounded-2xl border border-emerald-100 bg-white/80 p-4 sm:grid-cols-2">
              <div>
                <p class="text-xs uppercase tracking-widest text-slate-500">
                  {gettext("Response time")}
                </p>
                <p class="mt-2 text-sm font-semibold text-slate-900">
                  {gettext("Under 10 minutes")}
                </p>
              </div>
              <div>
                <p class="text-xs uppercase tracking-widest text-slate-500">
                  {gettext("Next available")}
                </p>
                <p class="mt-2 text-sm font-semibold text-slate-900">
                  {gettext("Today 3:30 PM")}
                </p>
              </div>
            </div>
          </div>
        </div>

        <div class="mt-10 grid gap-6 md:grid-cols-2 xl:grid-cols-3">
          <%= for doctor <- @doctors do %>
            <article class="flex h-full flex-col rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
              <div class="flex items-start justify-between">
                <div>
                  <p class="text-xs font-semibold uppercase tracking-[0.2em] text-emerald-700">
                    {doctor.role}
                  </p>
                  <h2 class="mt-2 text-xl font-semibold text-slate-900">{doctor.name}</h2>
                  <p class="mt-1 text-sm text-slate-600">{doctor.specialty}</p>
                </div>
                <span class="rounded-full bg-emerald-50 px-3 py-1 text-xs font-semibold text-emerald-700">
                  {doctor.availability}
                </span>
              </div>

              <div class="mt-4 grid gap-3 text-sm text-slate-600">
                <div class="flex items-center justify-between">
                  <span class="text-xs uppercase tracking-widest text-slate-500">
                    {gettext("Languages")}
                  </span>
                  <span class="font-medium text-slate-700">{doctor.languages}</span>
                </div>
                <div class="flex items-center justify-between">
                  <span class="text-xs uppercase tracking-widest text-slate-500">
                    {gettext("Years of experience")}
                  </span>
                  <span class="font-medium text-slate-700">{doctor.experience}</span>
                </div>
              </div>

              <div class="mt-6 flex flex-1 items-end gap-2">
                <button
                  type="button"
                  class="inline-flex flex-1 items-center justify-center rounded-xl border border-black px-4 py-2 text-sm font-semibold text-slate-900 transition hover:bg-emerald-300 hover:text-white"
                >
                  {gettext("Book appointment")}
                </button>
                <button
                  type="button"
                  class="inline-flex flex-1 items-center justify-center rounded-xl border border-slate-200 px-4 py-2 text-sm font-semibold text-slate-700 transition hover:border-emerald-400 hover:text-emerald-700"
                >
                  {gettext("View profile")}
                </button>
              </div>
            </article>
          <% end %>
        </div>
      </section>
    </Layouts.app>
    """
  end

  @impl true
  def handle_event("filter", %{"specialty" => specialty}, socket) do
    doctors =
      if specialty == all_specialties_label() do
        socket.assigns.all_doctors
      else
        Enum.filter(socket.assigns.all_doctors, fn doctor -> doctor.role == specialty end)
      end

    {:noreply, assign(socket, doctors: doctors, selected_specialty: specialty)}
  end

  defp path_with_query(uri) do
    parsed = URI.parse(uri)

    case parsed.query do
      nil -> parsed.path || "/doctors"
      query -> "#{parsed.path}?#{query}"
    end
  end

  defp specialties do
    [
      all_specialties_label(),
      gettext("Primary Care"),
      gettext("Dermatology"),
      gettext("Pediatrics"),
      gettext("Women's Health"),
      gettext("Mental Health")
    ]
  end

  defp all_specialties_label do
    gettext("All specialties")
  end

  defp doctors do
    [
      %{
        role: gettext("Primary Care"),
        name: "Dr. Minji Park",
        specialty: "Family Medicine",
        languages: "Korean, English",
        availability: gettext("Available today"),
        experience: gettext("12 years")
      },
      %{
        role: gettext("Dermatology"),
        name: "Dr. Hyeon Lee",
        specialty: "Dermatology & Aesthetics",
        languages: "Korean, English",
        availability: gettext("Next available"),
        experience: gettext("9 years")
      },
      %{
        role: gettext("Pediatrics"),
        name: "Dr. Jisoo Han",
        specialty: "Pediatric Care",
        languages: "Korean, English",
        availability: gettext("Available today"),
        experience: gettext("11 years")
      },
      %{
        role: gettext("Women's Health"),
        name: "Dr. Yuna Choi",
        specialty: "Women's Health & OB-GYN",
        languages: "Korean, English",
        availability: gettext("Next available"),
        experience: gettext("14 years")
      },
      %{
        role: gettext("Mental Health"),
        name: "Dr. Ara Kim",
        specialty: "Behavioral Health",
        languages: "Korean, English",
        availability: gettext("Available today"),
        experience: gettext("8 years")
      },
      %{
        role: gettext("Primary Care"),
        name: "Dr. Jun Seo",
        specialty: "Internal Medicine",
        languages: "Korean, English",
        availability: gettext("Next available"),
        experience: gettext("10 years")
      }
    ]
  end
end
