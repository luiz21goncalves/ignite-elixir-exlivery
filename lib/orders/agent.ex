defmodule Exlivery.Orders.Agent do
  use Agent

  alias Exlivery.Orders.Order

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Order{} = order) do
    uuid = UUID.uuid4()

    Agent.update(__MODULE__, &update_state(&1, order, uuid))

    {:ok, uuid}
  end

  def get(uuid), do: Access.get(__MODULE__, &get_user(&1, uuid))

  defp get_user(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, "Order not found"}
      order -> {:ok, order}
    end
  end

  defp update_state(state, %Order{} = order, uuid), do: Map.put(state, uuid, order)
end