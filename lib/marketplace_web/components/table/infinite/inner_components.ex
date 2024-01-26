defmodule MarketplaceWeb.Components.Table.Infinite.InnerComponents do
  @moduledoc false

  alias Phoenix.LiveView.JS

  use MarketplaceWeb, :html

  attr :id, :any, required: true, doc: "The parent component unique id."

  def top_loading(assigns) do
    ~H"""
    <div
      id={"#{@id}-top-loading-table"}
      class="absolute top-4 left-1/2 transform -translate-x-2/4 hidden"
      data-show={
        JS.show(
          transition: {"ease-in duration-300", "opacity-0", "opacity-100"},
          time: 300
        )
      }
      data-hide={
        JS.hide(
          transition: {"ease-out duration-300", "opacity-100", "opacity-0"},
          time: 300
        )
      }
    >
      <div class="bg-gray-50 border p-3 pb-1 rounded-lg drop-shadow-md">
        loading
      </div>
    </div>
    """
  end

  attr :id, :any, required: true, doc: "The parent component unique id."

  def bottom_loading(assigns) do
    ~H"""
    <div
      id={"#{@id}-bottom-loading-table"}
      class="absolute bottom-4 left-1/2 transform -translate-x-2/4 hidden"
      data-show={
        JS.show(
          transition: {"ease-in duration-500", "opacity-0", "opacity-100"},
          time: 500
        )
      }
      data-hide={
        JS.hide(
          transition: {"ease-out duration-500", "opacity-100", "opacity-0"},
          time: 500
        )
      }
    >
      <div class="bg-gray-50 border p-3 pb-1 rounded-lg drop-shadow-md">
        loading
      </div>
    </div>
    """
  end
end
