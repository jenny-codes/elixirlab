defmodule ElixirLab.Domain.Model.Experiment do
  alias ElixirLab.Domain.Model.{Alchemist, Equipment}
  @enforce_keys [:alchemist, :equipment, :materials]
  defstruct [:id, :alchemist, :equipment, :materials, :result]

  @key_material "phoenix ash"

  @spec new([{:alchemist, Alchemist.t()} | {:equipment, Equipment.t()} | {:materials, Enum.t()}]) ::
          struct()
  def new(attrs) do
    struct!(__MODULE__, attrs)
  end

  def has_key_material(%__MODULE__{} = experiment) do
    @key_material in experiment.materials
  end

  def key_material() do
    @key_material
  end
end
