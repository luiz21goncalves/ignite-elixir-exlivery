defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  import Exlivery.Factory

  describe "create/1" do
    setup do
      OrderAgent.start_link(%{})

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      :ok
    end

    test "creates the report file" do
      filename = "report_test.csv"

      expected_response =
        "12345678910,pizza,1,35.5japonesa,2,20.5,76.50\n" <>
          "12345678910,pizza,1,35.5japonesa,2,20.5,76.50\n"

      Report.create(filename)

      response = File.read!(filename)

      assert response == expected_response
    end

    test "creates the report file with a default name" do
      expected_response =
        "12345678910,pizza,1,35.5japonesa,2,20.5,76.50\n" <>
          "12345678910,pizza,1,35.5japonesa,2,20.5,76.50\n"

      Report.create()

      response = File.read!("report.csv")

      assert response == expected_response
    end
  end
end
