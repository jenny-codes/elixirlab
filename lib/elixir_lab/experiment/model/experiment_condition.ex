defmodule ElixirLab.Experiment.Model.ExperimentCondition do
  alias ElixirLab.Experiment.Model.{Alchemist, Equipment}

  @type t :: %__MODULE__{
          alchemist: Alchemist.t(),
          equipment: Equipment.t(),
          materials: [String.t()]
        }

  @enforce_keys [:alchemist, :equipment, :materials]
  defstruct [:alchemist, :equipment, :materials]

  def new(attrs) do
    struct!(__MODULE__, attrs)
  end

  def key_material() do
    "phoenix feather"
  end
end
