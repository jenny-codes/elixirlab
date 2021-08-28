defmodule ElixirLab.Lab.Domain.ExperimentServiceTest do
  use ExUnit.Case, async: true
  alias ElixirLab.Lab.Domain.Model.{Alchemist, Equipment, Experiment}
  alias ElixirLab.Lab.Domain.Service.ExperimentService

  describe "run_experiment/1" do
    test "return failed experiment when alchemist is an apprentice" do
      experiment =
        Experiment.new(
          alchemist: Alchemist.new(name: "Rookie", level: Alchemist.level_apprentice()),
          equipment: Equipment.new(name: "wok", use_condition: Equipment.condition_brand_new()),
          materials: ["detergent", "coin", Experiment.key_material()]
        )

      result = ExperimentService.run_experiment(experiment).result

      assert result == :failed
    end

    test "return failed experiment when equipment is worn out" do
      experiment =
        Experiment.new(
          alchemist: Alchemist.new(name: "Rookie", level: Alchemist.level_master()),
          equipment: Equipment.new(name: "wok", use_condition: Equipment.condition_worn_out()),
          materials: ["detergent", "coin", Experiment.key_material()]
        )

      result = ExperimentService.run_experiment(experiment).result

      assert result == :failed
    end

    test "return failed experiment when materials do not contain phonenix ash" do
      experiment =
        Experiment.new(
          alchemist: Alchemist.new(name: "Rookie", level: Alchemist.level_master()),
          equipment: Equipment.new(name: "wok", use_condition: Equipment.condition_brand_new()),
          materials: ["detergent", "coin", "rotten egg"]
        )

      result = ExperimentService.run_experiment(experiment).result

      assert result == :failed
    end

    test "return successful experiment when above conditions are met" do
      experiment =
        Experiment.new(
          alchemist: Alchemist.new(name: "Rookie", level: Alchemist.level_master()),
          equipment: Equipment.new(name: "wok", use_condition: Equipment.condition_brand_new()),
          materials: ["detergent", Experiment.key_material(), "rotten egg"]
        )

      result = ExperimentService.run_experiment(experiment).result

      assert result == :successful
    end
  end
end
