defmodule MarketplaceWeb.Admin.Disposition.ListLive.DataTable.InnerComponent do
  @moduledoc false

  alias MarketplaceWeb.Components.{Admin.SkipTrace, Table}

  use MarketplaceWeb, :html

  use PetalComponents

  attr :id, :any, required: true, doc: "The component unique id."

  attr :target, Target, default: nil

  attr :myself, :any, required: true

  attr :builder, AshQueryBuilder, required: true, doc: "The query builder."

  slot :actions, doc: "the slot for form actions, such as a submit button"

  def table(assigns) do
    ~H"""
    <Table.live_render id={"#{@id}_disposition_inner_table"} stream_name={:transactions}>
      <:headers :let={_target}>
        <Table.Header.render class={size(:contact)} title="Contact" />
      </:headers>

      <:row :let={transaction}>
        <Table.Row.Column.render class={size(:contact)}>
          <SkipTrace.live_render id={"skip_trace_#{transaction.id}"} entity={transaction.entity} />
        </Table.Row.Column.render>
      </:row>
    </Table.live_render>
    """
  end

  defp size(:contact), do: "min-w-[300px] max-w-[400px]"
end
