defmodule ElixirLab.Domain.Service.ExperimentService do
  alias ElixirLab.Domain.Model.{Alchemist, Equipment, ExperimentCondition, ExperimentResult}

  @spec produce_result(ExperimentCondition.t()) :: ExperimentResult.t()
  def produce_result(condition) do
    result =
      with true <- is_valid_alchemist(condition.alchemist),
           true <- is_valid_equipment(condition.equipment),
           true <- ExperimentCondition.has_key_material(condition) do
        ExperimentResult.result_successful()
      else
        _ -> ExperimentResult.result_failed()
      end

    ExperimentResult.new(condition: condition, result: result)
  end

  defp is_valid_alchemist(%Alchemist{} = alchemist) do
    !Alchemist.is_apprentice(alchemist)
  end

  defp is_valid_equipment(%Equipment{} = equipment) do
    !Equipment.is_worn_out(equipment)
  end
end
