defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent, as: OrderAgent

  import Exlivery.Factory

  describe "save/1" do
    test "saves the user" do
      OrderAgent.start_link(%{})

      order = build(:order)

      assert {:ok, __uuid} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link(%{})

      :ok
    end

    test "when the order is found, returns the order" do
      order = build(:order)

      {:ok, uuid} = OrderAgent.save(order)

      response = OrderAgent.get(uuid)

      expected_response = {:ok, order}

      assert response === expected_response
    end

    test "when the order is not found, returns an error" do
      response = OrderAgent.get("00000000000")

      expected_response = {:error, "Order not found"}

      assert response == expected_response
    end
  end

  describe "list_all/1" do
    setup do
      OrderAgent.start_link(%{})

      :ok
    end

    test "list all orders" do
      order1 = build(:order)
      order2 = build(:order)

      {:ok, uuid1} = OrderAgent.save(order1)

      {:ok, uuid2} = OrderAgent.save(order2)

      expected_response = %{uuid1 => order1, uuid2 => order2}

      response = OrderAgent.list_all()

      assert response === expected_response
    end
  end
end
