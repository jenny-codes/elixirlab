defmodule ElixirLab.Experiment.Service do
  alias ElixirLab.Experiment.Model.{
    Alchemist,
    Equipment,
    ExperimentCondition,
    ExperimentResult
  }

  @callback produce_result(ExperimentCondition.t()) :: Experiment.t()

  def produce_result(%ExperimentCondition{} = condition) do
    result =
      with true <- is_valid_alchemist(condition.alchemist),
           true <- is_valid_equipment(condition.equipment),
           true <- has_key_material(condition.materials) do
        ExperimentResult.result_successful()
      else
        _ -> ExperimentResult.result_failed()
      end

    ExperimentResult.new(condition: condition, result: result)
  end

  # ...

  defp is_valid_alchemist(%Alchemist{} = alchemist) do
    !Alchemist.is_apprentice(alchemist)
  end

  defp is_valid_equipment(%Equipment{} = equipment) do
    !Equipment.is_worn_out(equipment)
  end

  defp has_key_material(materials) do
    ExperimentCondition.key_material() in materials
  end
end
