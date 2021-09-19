defmodule ElixirLab.Domain.Store.ExperimentRepo do
  alias ElixirLab.Domain.Model.{Alchemist, Equipment, ExperimentResult}
  @callback get_alchemist(id :: number()) :: {:ok, Alchemist.t()} | {:error, term}
  @callback random_get_equipment() :: {:ok, [Equipment.t()]} | {:error, term}
  @callback save_experiment(ExperimentResult.t()) :: {:ok, ExperimentResult.t()} | {:error, term}
end
