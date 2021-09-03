defmodule ElixirLab.Experiment.Store do
  alias ElixirLabExternal.Repo.ExperimentRepo
  alias ElixirLab.Experiment.Model.{Alchemist, Equipment, ExperimentResult}
  @callback get_alchemist(id :: number()) :: {:ok, Alchemist.t()} | {:error, term}
  @callback random_get_equipment() :: {:ok, [Equipment.t()]} | {:error, term}
  @callback save_experiment(ExperimentResult.t()) :: {:ok, ExperimentResult.t()} | {:error, term}

  @impl_module Application.compile_env(:elixir_lab, :experiment_store, ExperimentRepo)

  defdelegate get_alchemist(id), to: @impl_module
  defdelegate random_get_equipment(), to: @impl_module
  defdelegate save_experiment(experiment_result), to: @impl_module
end
