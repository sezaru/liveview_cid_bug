defmodule MarketplaceWeb.Components.Helpers.Target do
  @moduledoc """
  A struct to be used when passing `LiveComponents` targets to other components.
  """

  alias Phoenix.LiveView

  use TypedStruct

  typedstruct enforce: true do
    field(:id, String.t())
    field(:module, Module.t())
  end

  @spec new(String.t(), Module.t()) :: t
  def new(id, module), do: struct!(__MODULE__, id: id, module: module)

  @spec send_message(map, t() | nil, pid) :: any
  def send_message(message, target, pid \\ self())
  def send_message(message, nil, pid), do: send(pid, message)

  def send_message(message, %__MODULE__{id: id, module: module}, pid),
    do: LiveView.send_update(pid, module, Map.put(message, :id, id))
end
