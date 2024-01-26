defmodule MarketplaceWeb.Components.Table.Row.Column do
  @moduledoc false

  use MarketplaceWeb, :html

  import PhxComponentHelpers

  attr :snap?, :boolean, default: false

  attr :class, :string, default: ""

  attr :rest, :global

  slot :inner_block

  def render(assigns) do
    assigns =
      assigns
      |> extend_class("px-6 py-3 break-words")
      |> extend_class(fn %{snap?: snap?} -> if snap?, do: "snap-start", else: "" end)

    ~H"""
    <div {@heex_class} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
