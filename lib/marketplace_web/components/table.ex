defmodule MarketplaceWeb.Components.Table do
  @moduledoc false

  alias MarketplaceWeb.Components.Table

  use MarketplaceWeb, :live_component

  import PhxComponentHelpers

  attr :id, :any, required: true, doc: "The component unique id."

  attr :class, :string, default: ""

  attr :rest, :global

  attr :stream_name, :atom, default: :rows, doc: "The stream name, defaults to `rows`."

  slot :headers, required: true
  slot :row, required: true

  def live_render(assigns), do: ~H"<.live_component module={__MODULE__} {assigns} />"

  def update(%{operation: :data, uid: uid, data: data}, socket) do
    %{uid: current_uid, stream_name: stream_name} = socket.assigns

    socket = stream(socket, stream_name, data, reset: current_uid != uid)

    {:ok, assign(socket, :uid, uid)}
  end

  def update(assigns, socket) do
    %{stream_name: stream_name} = assigns

    assigns =
      extend_class(
        assigns,
        "h-28 grow overflow-x-auto snap-x rounded-sm ring-1 ring-gray-200 bg-white"
      )

    socket =
      socket |> assign(assigns) |> assign(:uid, "FIRST") |> stream(stream_name, [], reset: true)

    {:ok, socket}
  end

  def handle_event("highlight-on-table", params, socket) do
    {:noreply, push_event(socket, "highlight-on-table", params)}
  end

  defp fetch_stream!(streams, stream_name), do: Map.fetch!(streams, stream_name)
end
