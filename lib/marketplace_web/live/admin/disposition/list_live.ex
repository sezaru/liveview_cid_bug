defmodule MarketplaceWeb.Admin.Disposition.ListLive do
  @moduledoc false

  alias MarketplaceWeb.Admin.Disposition.ListLive.DataTable
  alias MarketplaceWeb.Components.{Table, Helpers.Target}

  use MarketplaceWeb, :live_view

  use PetalComponents

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:loading, false)
      |> assign_new(:query, fn -> nil end)
      |> assign_new(:builder, fn -> AshQueryBuilder.new() end)

    {:ok, socket}
  end

  def handle_params(_params, _uri, socket) do
    send(self(), :load_properties_map)

    {:noreply, socket}
  end

  def handle_event("search", _, socket) do
    send(self(), :load_properties_map)

    {:noreply, assign(socket, :loading, true)}
  end

  def handle_info({:filter_finished, _}, socket) do
    send(self(), :load_properties_map)

    {:noreply, assign(socket, :loading, true)}
  end

  def handle_info(:load_properties_map, socket), do: {:noreply, find_by_geo_point(socket)}

  def handle_info(_, socket), do: {:noreply, socket}

  defp find_by_geo_point(socket) do
    uid = :crypto.strong_rand_bytes(16) |> Base.encode16()

    # NOTE: We need to add a sleep here to trigger the bug
    Process.sleep(:timer.seconds(1))

    batch = [
      %{
        id: "018d0c7d-8864-7d0d-ae59-d25bcc40d36d",
        entity: %{
          id: "018d288d-1091-72f0-8266-c13e4acfb691",
          skip_traces: [
            %{
              id: "018d46f4-03e8-7bf3-9070-c387b7dc3d92",
              valid?: nil,
              inserted_at: ~U[2024-01-26 18:06:53.416302Z],
              updated_at: ~U[2024-01-26 18:06:53.416302Z],
              email: nil,
              phone_number: "+1 (555) 555-5555"
            },
            %{
              id: "018d46f4-03e8-71f9-95d0-6d38f3c58c82",
              valid?: nil,
              inserted_at: ~U[2024-01-26 18:06:53.416302Z],
              updated_at: ~U[2024-01-26 18:06:53.416302Z],
              email: nil,
              phone_number: "+1 (555) 555-5555"
            },
            %{
              id: "018d46f4-03e8-786f-b420-ff216140010e",
              valid?: nil,
              inserted_at: ~U[2024-01-26 18:06:53.416302Z],
              updated_at: ~U[2024-01-26 18:06:53.416302Z],
              email: nil,
              phone_number: "+1 (555) 555-5555"
            },
            %{
              id: "018d46f4-03e8-758c-beff-5e4d4c0a4624",
              valid?: nil,
              inserted_at: ~U[2024-01-26 18:06:53.416302Z],
              updated_at: ~U[2024-01-26 18:06:53.416302Z],
              email: nil,
              phone_number: "+1 (555) 555-5555"
            },
            %{
              id: "018d46f4-03e8-7704-8012-34798e86b234",
              valid?: nil,
              inserted_at: ~U[2024-01-26 18:06:53.416302Z],
              updated_at: ~U[2024-01-26 18:06:53.416302Z],
              email: nil,
              phone_number: "+1 (555) 555-5555"
            },
            %{
              id: "018d46f4-03e8-7ec5-8634-8a9c603f5031",
              valid?: nil,
              inserted_at: ~U[2024-01-26 18:06:53.416302Z],
              updated_at: ~U[2024-01-26 18:06:53.416302Z],
              email: nil,
              phone_number: "+1 (555) 555-5555"
            },
            %{
              id: "018d46f4-03e8-7fda-a668-7918d34c1553",
              valid?: nil,
              inserted_at: ~U[2024-01-26 18:06:53.416302Z],
              updated_at: ~U[2024-01-26 18:06:53.416302Z],
              email: nil,
              phone_number: "+1 (555) 555-5555"
            },
            %{
              id: "018d46f4-03e8-7b02-9e20-abddc47fd29d",
              valid?: nil,
              inserted_at: ~U[2024-01-26 18:06:53.416302Z],
              updated_at: ~U[2024-01-26 18:06:53.416302Z],
              email: nil,
              phone_number: "+1 (555) 555-5555"
            }
          ]
        }
      }
    ]

    update_table(uid, batch)

    assign(socket, loading: false)
  end

  defp update_table(uid, results) do
    Target.new("list_disposition_table_disposition_inner_table", Table)
    |> then(&Target.send_message(%{operation: :data, uid: uid, data: results}, &1))
  end
end
