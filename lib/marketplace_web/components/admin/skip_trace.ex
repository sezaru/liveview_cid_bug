defmodule MarketplaceWeb.Components.Admin.SkipTrace do
  @moduledoc false

  alias MarketplaceWeb.Components.Admin.SkipTrace

  alias Phoenix.LiveView.AsyncResult

  use MarketplaceWeb, :live_component

  attr :id, :any, required: true, doc: "The component unique id."

  attr :entity, :map, required: true

  def live_render(assigns), do: ~H"<.live_component module={__MODULE__} {assigns} />"

  def update(assigns, socket) do
    {entity, assigns} = Map.pop(assigns, :entity)

    {fetched_skip_traces, _} = handle_skip_traces(entity.skip_traces)

    socket =
      socket
      |> assign(assigns)
      |> assign(skip_traces: AsyncResult.ok(%AsyncResult{}, fetched_skip_traces))

    {:ok, socket}
  end

  defp handle_skip_traces(skip_traces, original_skip_traces \\ %{}) do
    skip_traces =
      Enum.reject(skip_traces, fn
        {:error, _} -> true
        _ -> false
      end)

    original_phone_numbers = Map.get(original_skip_traces, :phone_numbers, [])

    phone_numbers =
      skip_traces
      |> Enum.reject(fn %{phone_number: phone_number} -> is_nil(phone_number) end)
      |> Kernel.++(original_phone_numbers)
      |> Enum.uniq_by(& &1.id)
      |> Enum.sort_by(& &1.inserted_at, {:desc, DateTime})
      |> Enum.sort_by(& &1.valid?, :desc)

    last_update = last_update(phone_numbers, [])

    found_anything? = not Enum.empty?(skip_traces)

    {%{phone_numbers: phone_numbers, last_update: last_update}, found_anything?}
  end

  defp last_update(phone_numbers, emails) do
    phone_numbers_updates = Enum.map(phone_numbers, & &1.updated_at)
    emails_updates = Enum.map(emails, & &1.updated_at)

    case phone_numbers_updates ++ emails_updates do
      [] -> nil
      updates -> Enum.max(updates, DateTime)
    end
  end
end
