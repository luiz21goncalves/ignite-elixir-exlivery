defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
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

  def order_factory do
    %Order{
      user_document: "12345678910",
      delivery_address: "Rua Qualquer",
      items: [
        build(:item),
        build(:item,
          description: "Temaki de atum",
          category: :japonesa,
          quantity: 2,
          unit_price: Decimal.new("20.5")
        )
      ],
      total_price: Decimal.new("76.50")
    }
  end
end
