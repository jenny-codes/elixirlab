defmodule ElixirLab.Lab.Adapter.ExperimentRepoTest do
  use ElixirLab.RepoCase, async: true
  alias ElixirLab.Lab.Domain.Model
  alias ElixirLab.Lab.Adapter.ExperimentRepo
  alias ElixirLab.Lab.Adapter.Schema

  describe "get_alchemist/1" do
    test "get a alchemist record by id and translate to alchemist model" do
      record = create_alchemist_record()

      result = ExperimentRepo.get_alchemist(record.id)

      assert %Model.Alchemist{} = result
      assert result.name == record.name
      assert result.level == Model.Alchemist.level_apprentice()
    end
  end

  describe "random_get_equipment/0" do
    test "get an equipment record by random selection and translate to equipment model" do
      record = create_equipment_record()

      result = ExperimentRepo.random_get_equipment()

      assert %Model.Equipment{} = result
      assert result.name == record.name
      assert result.use_condition == Model.Equipment.condition_worn_out()
    end
  end

  describe "save_experiment/1" do
    test "saves an experiment from model" do
      alchemist = create_alchemist_record()
      equipment = create_equipment_record()

      exp_model = %Model.Experiment{
        alchemist: alchemist,
        equipment: equipment,
        materials: ["egg", "mask", "ruby"],
        result: :successful
      }

      result = ExperimentRepo.save_experiment(exp_model)

      assert Repo.get(Schema.Experiment, result.id)
    end
  end

  defp create_alchemist_record do
    {:ok, record} =
      Repo.insert(%Schema.Alchemist{
        name: "Alchemist name",
        level: Model.Alchemist.level_apprentice()
      })

    record
  end

  defp create_equipment_record() do
    {:ok, record} =
      Repo.insert(%Schema.Equipment{
        name: "Equipment name",
        use_condition: Model.Equipment.condition_worn_out()
      })

    record
  end
end
