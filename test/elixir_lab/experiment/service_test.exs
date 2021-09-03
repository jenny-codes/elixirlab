defmodule ElixirLab.Experiment.ServiceTest do
  use ExUnit.Case, async: true

  alias ElixirLab.Experiment.Model.{
    Alchemist,
    Equipment,
    ExperimentCondition,
    ExperimentResult
  }

  alias ElixirLab.Experiment.Service

  describe "produce_result/1" do
    test "return failed experiment when alchemist is an apprentice" do
      condition =
        ExperimentCondition.new(
          alchemist: Alchemist.new(name: "Rookie", level: Alchemist.level_apprentice()),
          equipment: Equipment.new(name: "wok", use_condition: Equipment.condition_brand_new()),
          materials: ["detergent", "coin", ExperimentCondition.key_material()]
        )

      result = Service.produce_result(condition).result

      assert result == ExperimentResult.result_failed()
    end

    test "return failed experiment when equipment is worn out" do
      condition =
        ExperimentCondition.new(
          alchemist: Alchemist.new(name: "Rookie", level: Alchemist.level_master()),
          equipment: Equipment.new(name: "wok", use_condition: Equipment.condition_worn_out()),
          materials: ["detergent", "coin", ExperimentCondition.key_material()]
        )

      result = Service.produce_result(condition).result

      assert result == ExperimentResult.result_failed()
    end

    test "return failed experiment when materials do not contain phonenix ash" do
      condition =
        ExperimentCondition.new(
          alchemist: Alchemist.new(name: "Rookie", level: Alchemist.level_master()),
          equipment: Equipment.new(name: "wok", use_condition: Equipment.condition_brand_new()),
          materials: ["detergent", "coin", "rotten egg"]
        )

      result = Service.produce_result(condition).result

      assert result == ExperimentResult.result_failed()
    end

    test "return successful experiment when above conditions are met" do
      condition =
        ExperimentCondition.new(
          alchemist: Alchemist.new(name: "Rookie", level: Alchemist.level_master()),
          equipment: Equipment.new(name: "wok", use_condition: Equipment.condition_brand_new()),
          materials: ["detergent", ExperimentCondition.key_material(), "rotten egg"]
        )

      result = Service.produce_result(condition).result

      assert result == ExperimentResult.result_successful()
    end
  end
end
