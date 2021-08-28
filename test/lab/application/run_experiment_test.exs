defmodule ElixirLab.Lab.Application.RunExperimentTest do
  use ExUnit.Case, async: true
  alias ElixirLab.Lab.Domain.Model.{Alchemist, Equipment, Experiment}
  alias ElixirLab.Lab.Application.RunExperiment
  alias ElixirLab.Lab.MockExperimentRepo

  import Mox

  test "return elixir if the experiment succeeded" do
    successful_exp =
      Experiment.new(
        alchemist: %Alchemist{id: 1, name: "Succeeding", level: Alchemist.level_master()},
        equipment: %Equipment{
          name: "Cardbaord box",
          use_condition: Equipment.condition_brand_new()
        },
        materials: [Experiment.key_material()],
        result: :successful
      )

    stub_repo =
      MockExperimentRepo
      |> expect(:get_alchemist, fn _id -> successful_exp.alchemist end)
      |> expect(:random_get_equipment, fn -> successful_exp.equipment end)
      |> expect(:save_experiment, fn _experiment -> {:ok, successful_exp} end)

    result = RunExperiment.call(successful_exp.alchemist.id, successful_exp.materials, stub_repo)

    assert result == "elixir"
  end

  test "return no elixir if the experiment failed" do
    failed_exp =
      Experiment.new(
        alchemist: %Alchemist{id: 1, name: "Failing", level: Alchemist.level_apprentice()},
        equipment: %Equipment{
          name: "Holed tent",
          use_condition: Equipment.condition_worn_out()
        },
        materials: ["random material"],
        result: :failed
      )

    stub_repo =
      MockExperimentRepo
      |> expect(:get_alchemist, fn _id -> failed_exp.alchemist end)
      |> expect(:random_get_equipment, fn -> failed_exp.equipment end)
      |> expect(:save_experiment, fn _experiment -> {:ok, failed_exp} end)

    result = RunExperiment.call(failed_exp.alchemist.id, failed_exp.materials, stub_repo)

    assert result == "no elixir"
  end

  test "persist the experiment" do
    successful_exp =
      Experiment.new(
        alchemist: %Alchemist{id: 1, name: "Succeeding", level: Alchemist.level_master()},
        equipment: %Equipment{
          name: "Cardbaord box",
          use_condition: Equipment.condition_brand_new()
        },
        materials: [Experiment.key_material()],
        result: :successful
      )

    stub_repo =
      MockExperimentRepo
      |> expect(:get_alchemist, fn _id -> successful_exp.alchemist end)
      |> expect(:random_get_equipment, fn -> successful_exp.equipment end)
      |> expect(:save_experiment, fn _experiment -> {:ok, successful_exp} end)

    RunExperiment.call(successful_exp.alchemist.id, successful_exp.materials, stub_repo)

    verify!()
  end
end
