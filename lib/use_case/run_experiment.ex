defmodule ElixirLab.UseCase.RunExperiment do
  alias ElixirLab.Domain.Store.ExperimentRepo
  alias ElixirLab.Domain.Model.{ExperimentCondition, ExperimentResult}
  alias ElixirLab.Domain.Service.ExperimentService

  @spec call(integer(), Enum.t(), ExperimentRepo.t()) :: String.t()
  def call(alchemist_id, materials, experiment_repo) do
    alchemist = experiment_repo.get_alchemist(alchemist_id)
    equipment = experiment_repo.random_get_equipment()

    experiment =
      [alchemist: alchemist, equipment: equipment, materials: materials]
      |> ExperimentCondition.new()
      |> ExperimentService.produce_result()

    {:ok, _} = experiment_repo.save_experiment(experiment)

    if ExperimentResult.is_successful(experiment) do
      "elixir"
    else
      "no elixir"
    end
  end
end
