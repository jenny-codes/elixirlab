defmodule ElixirLab.Lab.Domain.Service.ExperimentService do
  alias ElixirLab.Lab.Domain.Model.{Alchemist, Equipment, Experiment}

  @callback run_experiment(Experiment.t()) :: Experiment.t()

  @spec run_experiment(Experiment.t()) :: Experiment.t()
  def run_experiment(experiment) do
    result =
      with true <- is_valid_alchemist(experiment.alchemist),
           true <- is_valid_equipment(experiment.equipment),
           true <- Experiment.has_key_material(experiment) do
        :successful
      else
        _ -> :failed
      end

    Map.put(experiment, :result, result)
  end

  defp is_valid_alchemist(%Alchemist{} = alchemist) do
    !Alchemist.is_apprentice(alchemist)
  end

  defp is_valid_equipment(%Equipment{} = equipment) do
    !Equipment.is_worn_out(equipment)
  end
end
