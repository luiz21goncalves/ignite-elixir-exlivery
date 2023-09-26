defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.Item
  alias Exlivery.Users.User

  def user_factory do
    %User{
      name: "John Doe",
      email: "john.doe@email.com",
      document: "12345678910",
      age: 30,
      address: "Rua Qualquer"
    }
  end

  def item_factory do
    %Item{
      description: "Pizza de peperoni",
      category: :pizza,
      quantity: 1,
      unit_price: Decimal.new("35.5")
    }
  end
end
