defmodule MarketplaceWeb.Admin.Disposition.ListLive.DataTable do
  @moduledoc false

  alias MarketplaceWeb.Admin.Disposition.ListLive.DataTable.InnerComponent

  alias MarketplaceWeb.Components.Helpers.Target

  use MarketplaceWeb, :live_component

  attr :id, :any, required: true, doc: "The component unique id."

  attr :params, :map, required: true, doc: "The URL params."

  attr :query, Ash.Query, default: nil, doc: "The Ash query to get the data."

  attr :actions_column_class, :string, default: "min-w-[120px]"

  slot :actions, doc: "The actions buttons."

  slot :actions_column, doc: "The actions column."

  def live_render(assigns), do: ~H"<.live_component module={__MODULE__} {assigns} />"

  def handle_event("highlight-on-map", params, socket) do
    {:noreply, push_event(socket, "highlight-on-map", params)}
  end

  def update(%{operation: :update_sorter, sorter: sorter}, socket) do
    %{builder: builder} = socket.assigns

    builder = builder |> AshQueryBuilder.reset_sorters() |> AshQueryBuilder.add_sorter(sorter)

    send_builder_query(builder)

    {:ok, assign(socket, builder: builder)}
  end

  def update(assigns, socket) do
    %{params: params, query: query} = assigns

    builder = get_builder(params)

    socket =
      socket
      |> assign(assigns)
      |> assign(builder: builder)
      |> assign(query: query)

    {:ok, socket}
  end

  defp get_builder(params) do
    case Map.get(params, :disposition_builder) do
      nil -> AshQueryBuilder.new()
      builder -> AshQueryBuilder.parse(builder)
    end
  end

  defp send_builder_query(builder) do
    url_query_builder = AshQueryBuilder.to_params(builder, with_disabled?: true)

    send(self(), {:params, %{disposition_builder: url_query_builder}})
  end
end
