defmodule ElixirLab.Domain.Repo.ExperimentRepo do
  alias ElixirLab.Domain.Model.{Alchemist, Equipment, Experiment}
  @callback get_alchemist(id :: number()) :: {:ok, Alchemist.t()} | {:error, term}
  @callback random_get_equipment() :: {:ok, [Equipment.t()]} | {:error, term}
  @callback save_experiment(Experiment.t()) :: {:ok, Experiment.t()} | {:error, term}
end
