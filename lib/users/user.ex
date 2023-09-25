defmodule Exlivery.Users.User do
  @keys [:name, :email, :document, :age]
  @enforce_keys @keys

  defstruct @keys

  def build(name, email, document, age) when age >= 18 and is_bitstring(document) do
    {:ok,
     %__MODULE__{
       name: name,
       email: email,
       document: document,
       age: age
     }}
  end

  def build(_name, _email, _document, _age), do: {:error, "Invalid parameters"}
end
