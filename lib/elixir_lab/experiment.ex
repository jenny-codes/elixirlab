defmodule ElixirLab.Experiment do
  alias ElixirLab.Experiment.Service
  alias ElixirLab.Experiment.Store
  alias ElixirLab.Experiment.Model

  def run(alchemist_id, materials, experiment_repo \\ Store)

  def run(alchemist_id, materials, experiment_store) do
    condition =
      Model.ExperimentCondition.new(
        alchemist: experiment_store.get_alchemist(alchemist_id),
        equipment: experiment_store.random_get_equipment(),
        materials: materials
      )

    experiment_result = Service.produce_result(condition)

    {:ok, _experiment} = experiment_store.save_experiment(experiment_result)

    if Model.ExperimentResult.is_successful(experiment_result) do
      "elixir!"
    else
      "no elixir"
    end
  end
end
