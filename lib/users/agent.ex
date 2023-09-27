defmodule Exlivery.Users.Agent do
  use Agent

  alias Exlivery.Users.User

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user), do: Agent.update(__MODULE__, &update_state(&1, user))

  def get(document), do: Agent.get(__MODULE__, &get_user(&1, document))

  defp get_user(state, document) do
    case Map.get(state, document) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp update_state(state, %User{document: document} = user), do: Map.put(state, document, user)
end
