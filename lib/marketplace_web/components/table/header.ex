defmodule MarketplaceWeb.Components.Table.Header do
  @moduledoc false

  use MarketplaceWeb, :html

  import PhxComponentHelpers

  attr :icon, :atom, default: nil

  attr :title, :string, required: true

  attr :snap?, :boolean, default: false

  attr :class, :string, default: ""

  attr :rest, :global

  slot :inner_block

  def render(assigns) do
    assigns =
      assigns
      |> extend_class("px-6 py-3")
      |> extend_class(fn %{snap?: snap?} -> if snap?, do: "snap-start", else: "" end)

    ~H"""
    <div {@heex_class} {@rest}>
      <span class="flex justify-start space-x-1">
        <.icon :if={@icon} name={@icon} class="min-w-[16px] max-w-[16px] min-h-[16px] max-h-[16px]" />
        <span class="truncate uppercase"><%= @title %></span>
        <%= render_slot(@inner_block) %>
      </span>
    </div>
    """
  end
end
