defmodule ElixirLab.Adapter.CLITest do
  use ExUnit.Case, async: true
  alias ElixirLab.Domain.Model.{Alchemist, Equipment, ExperimentCondition}
  alias ElixirLab.MockExperimentRepo
  alias ElixirLab.Adapter.CLI

  import ExUnit.CaptureIO
  import Mox

  test "format submit command and print result" do
    prepare_experiment_repo()

    result =
      capture_io(fn ->
        CLI.main([
          "submit",
          "--aid",
          "1",
          "--materials",
          "#{ExperimentCondition.key_material()},whatever"
        ])
      end)

    assert result == "elixir\n"
  end

  defp prepare_experiment_repo() do
    MockExperimentRepo
    |> expect(:get_alchemist, fn _id ->
      Alchemist.new(name: "hi", level: Alchemist.level_master())
    end)
    |> expect(:random_get_equipment, fn ->
      Equipment.new(name: "Cardbaord box", use_condition: Equipment.condition_brand_new())
    end)
    |> expect(:save_experiment, fn exp -> {:ok, exp} end)
  end
end
