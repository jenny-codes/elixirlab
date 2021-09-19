defmodule ElixirLab.Domain.Model.ExperimentCondition do
  alias ElixirLab.Domain.Model.{Alchemist, Equipment}
  @enforce_keys [:alchemist, :equipment, :materials]
  defstruct [:alchemist, :equipment, :materials]

  @type t :: %__MODULE__{
          alchemist: Alchemist.t(),
          equipment: Equipment.t(),
          materials: Enum.t()
        }

  def new(attrs) do
    struct!(__MODULE__, attrs)
  end

  def has_key_material(%__MODULE__{} = experiment) do
    key_material() in experiment.materials
  end

  def key_material() do
    "phoenix feather"
  end
end
