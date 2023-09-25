defmodule Exlivery.Orders.Order do
  @keys [:user_document, :delivery_address, :items, :total_price]
  @enforce_keys @keys

  defstruct @keys

  def build do
    {:ok,
     %__MODULE__{
       user_document: nil,
       delivery_address: nil,
       items: nil,
       total_price: nil
     }}
  end
end
