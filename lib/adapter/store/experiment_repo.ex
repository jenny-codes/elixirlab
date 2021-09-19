defmodule ElixirLab.Adapter.Store.ExperimentRepo do
  alias ElixirLab.Domain.Model
  alias ElixirLab.Domain.Store.ExperimentRepo

  alias ElixirLab.Repo
  import Ecto.Query, warn: false
  alias ElixirLab.Adapter.Store.Schema

  @behaviour ExperimentRepo

  @impl ExperimentRepo
  def get_alchemist(id) do
    record = Repo.get(Schema.User, id)
    Model.Alchemist.new(name: record.name, level: record.level)
  end

  @impl ExperimentRepo
  def random_get_equipment() do
    [record] = Repo.all(from(Schema.Equipment, order_by: fragment("RANDOM()"), limit: 1))

    Model.Equipment.new(name: record.name, use_condition: record.use_condition)
  end

  @impl ExperimentRepo
  def save_experiment(exp) do
    exp_schema = %Schema.Experiment{
      user_id: exp.condition.alchemist.id,
      equipment_id: exp.condition.equipment.id,
      materials: Enum.join(exp.condition.materials, ","),
      result: Atom.to_string(exp.result)
    }

    {:ok, _} = Repo.insert(exp_schema, on_conflict: :replace_all, conflict_target: :id)

    exp
  end
end
