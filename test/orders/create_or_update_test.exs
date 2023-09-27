defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      Exlivery.start_agents()

      user = build(:user)

      UserAgent.save(user)

      item1 = build(:item)

      item2 =
        build(:item,
          description: "Temaki de atum",
          category: :japonesa,
          quantity: 2,
          unit_price: Decimal.new("20.5")
        )

      {:ok, user_document: user.document, item1: item1, item2: item2}
    end

    test "when all params are valid, saves the order", %{
      user_document: user_document,
      item1: item1,
      item2: item2
    } do
      params = %{user_document: user_document, items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert {:ok, __uuid} = response
    end

    test "when there is no user with given document, returns an error", %{
      item1: item1,
      item2: item2
    } do
      params = %{user_document: "00000000000", items: [item1, item2]}

      expected_response = {:error, "User not found"}

      response = CreateOrUpdate.call(params)

      assert response == expected_response
    end

    test "when there are invalid itens, returns an error", %{
      user_document: user_document,
      item1: item1,
      item2: item2
    } do
      params = %{user_document: user_document, items: [%{item1 | quantity: 0}, item2]}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid items"}

      assert response == expected_response
    end

    test "when there are no itens, returns an error", %{user_document: user_document} do
      params = %{user_document: user_document, items: []}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
