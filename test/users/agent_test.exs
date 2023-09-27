defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "save/1" do
    test "saves the user" do
      UserAgent.start_link(%{})

      user = build(:user)

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      document = "98765432101"

      {:ok, document: document}
    end

    test "when the user is found, returns the user", %{document: document} do
      :user
      |> build(document: document)
      |> UserAgent.save()

      response = UserAgent.get(document)

      expected_response =
        {:ok,
         %User{
           name: "John Doe",
           email: "john.doe@email.com",
           document: "98765432101",
           age: 30,
           address: "Rua Qualquer"
         }}

      assert response === expected_response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("00000000000")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
