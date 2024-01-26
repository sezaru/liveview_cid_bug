defmodule MarketplaceWeb.Components.Admin.SkipTrace.Row do
  @moduledoc false

  use MarketplaceWeb, :live_component

  attr :id, :string, doc: ""

  def live_render(assigns), do: ~H"<.live_component module={__MODULE__} {assigns} />"

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  def render(assigns) do
    ~H"""
    <div id={@id} class="flex items-center gap-1">
      cid: <%= @myself %>
    </div>
    """
  end
end
