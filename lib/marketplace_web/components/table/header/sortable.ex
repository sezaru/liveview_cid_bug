defmodule MarketplaceWeb.Components.Table.Header.Sortable do
  @moduledoc false

  alias MarketplaceWeb.Components.{Table.Header}

  alias MarketplaceWeb.Components.Helpers.Target

  alias AshQueryBuilder.Sorter

  use MarketplaceWeb, :live_component

  import PhxComponentHelpers

  attr :id, :any, required: true, doc: "The component unique id."

  attr :target, Target, default: nil

  attr :builder, AshQueryBuilder, required: true, doc: "The query builder."

  attr :key, :string, required: true
  attr :field, :atom, required: true

  attr :icon, :atom, default: nil

  attr :title, :string, required: true

  attr :tooltip_name, :string, default: "column"

  attr :snap?, :boolean, default: false

  attr :nils_last?, :boolean, default: false

  attr :class, :string, default: ""

  attr :rest, :global

  slot :inner_block

  def live_render(assigns), do: ~H"<.live_component module={__MODULE__} {assigns} />"

  def update(%{builder: builder, key: key} = assigns, socket) do
    order = find_order(builder, key)

    assigns = assigns |> Map.drop([:builder]) |> extend_class("")

    socket = socket |> assign(assigns) |> assign(order: order)

    {:ok, socket}
  end

  def handle_event("update_sort", _, socket) do
    %{id: id, key: key, field: field, order: order, target: target, nils_last?: nils_last?} =
      socket.assigns

    order = update_order(order, nils_last?)

    sorter = create_sorter(key, field, order)

    Target.send_message(%{operation: :update_sorter, sorter: sorter}, target)

    socket =
      socket
      |> assign(order: order)
      |> push_event("js-exec", %{to: "##{id}-button", attr: "data-after-clear"})

    {:noreply, socket}
  end

  defp find_order(builder, id) do
    with %{order: order} <- AshQueryBuilder.find_sorter(builder, id) do
      order
    end
  end

  defp start_loading(id, target) do
    JS.set_attribute({"disabled", ""})
    |> JS.add_class("hidden", to: "##{id}-sort-icon", time: 0)
    |> JS.remove_class("hidden", to: "##{id}-loading", time: 0)
    |> JS.push("update_sort", target: target)
  end

  defp end_loading(id) do
    JS.remove_attribute("disabled")
    |> JS.add_class("hidden", to: "##{id}-loading", time: 0)
    |> JS.remove_class("hidden", to: "##{id}-sort-icon", time: 0)
  end

  defp change_sort_icons_on_leave(js \\ %JS{}, id) do
    js
    |> JS.add_class("hidden", to: "##{id}-next", time: 0)
    |> JS.remove_class("hidden", to: "##{id}-current", time: 0)
  end

  defp change_sort_icons_on_enter(id) do
    JS.add_class("hidden", to: "##{id}-current", time: 0)
    |> JS.remove_class("hidden", to: "##{id}-next", time: 0)
  end

  defp update_order(nil, nils_last?), do: asc(nils_last?)

  defp update_order(:asc, nils_last?), do: desc(nils_last?)
  defp update_order(:asc_nils_last, nils_last?), do: desc(nils_last?)

  defp update_order(:desc, nils_last?), do: asc(nils_last?)
  defp update_order(:desc_nils_last, nils_last?), do: asc(nils_last?)

  defp create_sorter(id, field, order), do: Sorter.new(id, field, order)

  defp asc(true), do: :asc_nils_last
  defp asc(_nils_last?), do: :asc

  defp desc(true), do: :desc_nils_last
  defp desc(_nils_last?), do: :desc
end
