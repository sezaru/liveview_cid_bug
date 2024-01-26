defmodule MarketplaceWeb.Components.Table.GoToTop do
  @moduledoc false

  alias Phoenix.LiveView.JS

  use MarketplaceWeb, :html

  attr :id, :any, required: true, doc: "The parent component unique id."

  attr :tbody_id, :any, required: true, doc: "The table tbody unique id."

  def render(assigns) do
    ~H"""
    <.icon_button
      id={"#{@id}-go-to-top-button"}
      type="button"
      size="xs"
      class="absolute bottom-4 right-4 bg-gray-200 hidden"
      phx-click={JS.dispatch("go_to_top", to: @tbody_id)}
    >
      <Heroicons.arrow_small_up solid />
    </.icon_button>
    """
  end
end
