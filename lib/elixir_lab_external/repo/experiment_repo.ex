defmodule ElixirLabExternal.Repo.ExperimentRepo do
  alias ElixirLab.Experiment.Store
  alias ElixirLab.Experiment.Model
  alias ElixirLabExternal.Repo.Schema

  alias ElixirLab.Repo
  import Ecto.Query, warn: false

  @behaviour Store

  @impl Store
  def get_alchemist(id) do
    record = Repo.get(Schema.User, id)
    Model.Alchemist.new(name: record.name, level: record.level)
  end

  @impl Store
  def random_get_equipment() do
    [record] = Repo.all(from(Schema.Equipment, order_by: fragment("RANDOM()"), limit: 1))

    Model.Equipment.new(name: record.name, use_condition: record.use_condition)
  end

  @impl Store
  def save_experiment(exp) do
    exp_schema = %Schema.Experiment{
      user_id: exp.condition.alchemist.id,
      equipment_id: exp.condition.equipment.id,
      materials: Enum.join(exp.condition.materials, ","),
      result: Atom.to_string(exp.result)
    }

    with {:ok, record} <-
           Repo.insert(exp_schema, on_conflict: :replace_all, conflict_target: :id),
         exp_model <- Map.put(exp, :id, record.id) do
      {:ok, exp_model}
    end
  end
end
