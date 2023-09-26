defmodule Exlivery.Factory do
  use ExMachina

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
end
