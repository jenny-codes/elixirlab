defmodule ElixirLab.UseCase.RunExperimentTest do
  use ExUnit.Case, async: true
  alias ElixirLab.Domain.Model.{Alchemist, Equipment, ExperimentCondition, ExperimentResult}
  alias ElixirLab.UseCase.RunExperiment
  alias ElixirLab.MockExperimentRepo

  import Mox

  test "return elixir if the experiment succeeded" do
    successful_exp_condition =
      ExperimentCondition.new(
        alchemist: Alchemist.new(name: "Succeeding", level: Alchemist.level_master()),
        equipment:
          Equipment.new(
            name: "Cardbaord box",
            use_condition: Equipment.condition_brand_new()
          ),
        materials: [ExperimentCondition.key_material()]
      )

    successful_exp =
      ExperimentResult.new(
        condition: successful_exp_condition,
        result: ExperimentResult.result_successful()
      )

    stub_repo =
      MockExperimentRepo
      |> expect(:get_alchemist, fn _id -> successful_exp_condition.alchemist end)
      |> expect(:random_get_equipment, fn -> successful_exp_condition.equipment end)
      |> expect(:save_experiment, fn _experiment -> {:ok, successful_exp} end)

    result = RunExperiment.call(3, successful_exp_condition.materials, stub_repo)

    assert result == "elixir"
  end

  test "return no elixir if the experiment failed" do
    failed_exp_condition =
      ExperimentCondition.new(
        alchemist: Alchemist.new(name: "Failing", level: Alchemist.level_master()),
        equipment:
          Equipment.new(
            name: "Miserably unusable",
            use_condition: Equipment.condition_worn_out()
          ),
        materials: ["useless stuff"]
      )

    failed_exp =
      ExperimentResult.new(
        condition: failed_exp_condition,
        result: ExperimentResult.result_failed()
      )

    stub_repo =
      MockExperimentRepo
      |> expect(:get_alchemist, fn _id -> failed_exp_condition.alchemist end)
      |> expect(:random_get_equipment, fn -> failed_exp_condition.equipment end)
      |> expect(:save_experiment, fn _experiment -> {:ok, failed_exp} end)

    result = RunExperiment.call(3, failed_exp_condition.materials, stub_repo)

    assert result == "no elixir"
  end

  test "persist the experiment" do
    successful_exp_condition =
      ExperimentCondition.new(
        alchemist: Alchemist.new(name: "Succeeding", level: Alchemist.level_master()),
        equipment:
          Equipment.new(
            name: "Cardbaord box",
            use_condition: Equipment.condition_brand_new()
          ),
        materials: [ExperimentCondition.key_material()]
      )

    successful_exp =
      ExperimentResult.new(
        condition: successful_exp_condition,
        result: ExperimentResult.result_successful()
      )

    stub_repo =
      MockExperimentRepo
      |> expect(:get_alchemist, fn _id -> successful_exp_condition.alchemist end)
      |> expect(:random_get_equipment, fn -> successful_exp_condition.equipment end)
      |> expect(:save_experiment, fn _experiment -> {:ok, successful_exp} end)

    RunExperiment.call(3, successful_exp_condition.materials, stub_repo)

    verify!()
  end
end
