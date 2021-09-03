defmodule ElixirLab.Integration.ExperimentTest do
  use ElixirLab.RepoCase, async: true
  alias ElixirLab.Experiment.Model
  alias ElixirLabExternal.Repo.Schema

  test "run_experiment/3 happy path works" do
    valid_alchemist = create_valid_alchemist()
    # This equipment will be chosen because it is the only one.
    create_valid_equipment()
    valid_materials = [Model.ExperimentCondition.key_material()]

    result = ElixirLab.run_experiment(valid_alchemist.id, valid_materials)

    assert result == "elixir!"
  end

  defp create_valid_alchemist() do
    {:ok, record} =
      Repo.insert(%Schema.User{
        name: "A good alchemist",
        level: Model.Alchemist.level_master()
      })

    record
  end

  defp create_valid_equipment() do
    {:ok, record} =
      Repo.insert(%Schema.Equipment{
        name: "A good equipment",
        use_condition: Model.Equipment.condition_brand_new()
      })

    record
  end
end
