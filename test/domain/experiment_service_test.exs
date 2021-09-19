defmodule ElixirLab.Domain.ExperimentServiceTest do
  use ExUnit.Case, async: true
  alias ElixirLab.Domain.Model.{Alchemist, Equipment, ExperimentCondition, ExperimentResult}
  alias ElixirLab.Domain.Service.ExperimentService

  describe "produce_result/1" do
    test "return failed experiment when alchemist is an apprentice" do
      exp_condition =
        ExperimentCondition.new(
          alchemist: Alchemist.new(name: "Rookie", level: Alchemist.level_apprentice()),
          equipment: Equipment.new(name: "wok", use_condition: Equipment.condition_brand_new()),
          materials: ["unimportant stuff", ExperimentCondition.key_material()]
        )

      result = ExperimentService.produce_result(exp_condition).result

      assert result == ExperimentResult.result_failed()
    end

    test "return failed experiment when equipment is worn out" do
      exp_condition =
        ExperimentCondition.new(
          alchemist: Alchemist.new(name: "Rookie", level: Alchemist.level_master()),
          equipment: Equipment.new(name: "wok", use_condition: Equipment.condition_worn_out()),
          materials: ["unimportant stuff", ExperimentCondition.key_material()]
        )

      result = ExperimentService.produce_result(exp_condition).result

      assert result == ExperimentResult.result_failed()
    end

    test "return failed experiment when materials do not contain key material" do
      exp_condition =
        ExperimentCondition.new(
          alchemist: Alchemist.new(name: "Rookie", level: Alchemist.level_master()),
          equipment: Equipment.new(name: "wok", use_condition: Equipment.condition_brand_new()),
          materials: ["detergent", "coin", "rotten egg"]
        )

      result = ExperimentService.produce_result(exp_condition).result

      assert result == ExperimentResult.result_failed()
    end

    test "return successful experiment when above conditions are met" do
      exp_condition =
        ExperimentCondition.new(
          alchemist: Alchemist.new(name: "Rookie", level: Alchemist.level_master()),
          equipment: Equipment.new(name: "wok", use_condition: Equipment.condition_brand_new()),
          materials: ["detergent", ExperimentCondition.key_material(), "rotten egg"]
        )

      result = ExperimentService.produce_result(exp_condition).result

      assert result == ExperimentResult.result_successful()
    end
  end
end
