defmodule ElixirLab.Model.ExperimentTest do
  use ExUnit.Case, async: true
  alias ElixirLab.Experiment.Model
  alias ElixirLab.Experiment
  alias ElixirLab.MockExperimentRepo

  import Mox

  test "run_experiment/3" do
    successful_exp_condition =
      Model.ExperimentCondition.new(
        alchemist: %Model.Alchemist{
          id: 1,
          name: "Succeeding",
          level: Model.Alchemist.level_master()
        },
        equipment: %Model.Equipment{
          name: "Cardbaord box",
          use_condition: Model.Equipment.condition_brand_new()
        },
        materials: [Model.ExperimentCondition.key_material()]
      )

    stub_repo =
      MockExperimentRepo
      |> expect(:get_alchemist, fn _id -> successful_exp_condition.alchemist end)
      |> expect(:random_get_equipment, fn -> successful_exp_condition.equipment end)
      |> expect(:save_experiment, fn _experiment -> {:ok, :notimportant} end)

    result =
      Experiment.run(
        successful_exp_condition.alchemist.id,
        successful_exp_condition.materials,
        stub_repo
      )

    assert result == "elixir!"
  end

  test "return no elixir if the experiment failed" do
    failed_exp =
      Model.ExperimentResult.new(
        condition:
          Model.ExperimentCondition.new(
            alchemist: %Model.Alchemist{
              id: 1,
              name: "Failing",
              level: Model.Alchemist.level_apprentice()
            },
            equipment: %Model.Equipment{
              name: "Holed tent",
              use_condition: Model.Equipment.condition_worn_out()
            },
            materials: ["random material"]
          ),
        result: Model.ExperimentResult.result_failed()
      )

    stub_repo =
      MockExperimentRepo
      |> expect(:get_alchemist, fn _id -> failed_exp.condition.alchemist end)
      |> expect(:random_get_equipment, fn -> failed_exp.condition.equipment end)
      |> expect(:save_experiment, fn _experiment -> {:ok, failed_exp} end)

    result =
      Experiment.run(failed_exp.condition.alchemist.id, failed_exp.condition.materials, stub_repo)

    assert result == "no elixir"
  end

  test "persist the Model.Experiment" do
    successful_exp =
      Model.ExperimentResult.new(
        condition:
          Model.ExperimentCondition.new(
            alchemist: %Model.Alchemist{
              id: 1,
              name: "Succeeding",
              level: Model.Alchemist.level_master()
            },
            equipment: %Model.Equipment{
              name: "Cardbaord box",
              use_condition: Model.Equipment.condition_brand_new()
            },
            materials: [Model.ExperimentCondition.key_material()]
          ),
        result: Model.ExperimentResult.result_successful()
      )

    stub_repo =
      MockExperimentRepo
      |> expect(:get_alchemist, fn _id -> successful_exp.condition.alchemist end)
      |> expect(:random_get_equipment, fn -> successful_exp.condition.equipment end)
      |> expect(:save_experiment, fn _experiment -> {:ok, successful_exp} end)

    Experiment.run(
      successful_exp.condition.alchemist.id,
      successful_exp.condition.materials,
      stub_repo
    )

    verify!()
  end
end
