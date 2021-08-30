defmodule ElixirLab.UseCase.RunExperiment do
  alias ElixirLab.Domain.Model.Experiment
  alias ElixirLab.Domain.Service.ExperimentService

  def call(alchemist_id, materials, experiment_repo) do
    alchemist = experiment_repo.get_alchemist(alchemist_id)
    equipment = experiment_repo.random_get_equipment()

    {:ok, experiment} =
      [alchemist: alchemist, equipment: equipment, materials: materials]
      |> Experiment.new()
      |> ExperimentService.run_experiment()
      |> experiment_repo.save_experiment()

    case experiment.result do
      :successful -> "elixir"
      :failed -> "no elixir"
    end
  end
end
