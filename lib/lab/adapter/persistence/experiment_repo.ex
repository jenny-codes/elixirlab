defmodule ElixirLab.Lab.Adapter.ExperimentRepo do
  alias ElixirLab.Lab.Domain.Model
  alias ElixirLab.Lab.Domain.Repo.ExperimentRepo

  alias ElixirLab.Repo
  alias ElixirLab.Lab.Adapter.Schema
  import Ecto.Query, warn: false

  @behaviour ExperimentRepo

  @impl ExperimentRepo
  def get_alchemist(id) do
    record = Repo.get(Schema.Alchemist, id)
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
      alchemist_id: exp.alchemist.id,
      equipment_id: exp.equipment.id,
      materials: Enum.join(exp.materials, ","),
      result: Atom.to_string(exp.result)
    }

    {:ok, record} = Repo.insert(exp_schema, on_conflict: :replace_all, conflict_target: :id)

    Map.put(exp, :id, record.id)
  end
end
