defmodule ElixirLab.Experiment.Model.Equipment do
  @enforce_keys [:use_condition]
  defstruct [:id, :name, :use_condition]

  @condition_worn_out :worn_out
  @condition_brand_new :brand_new

  @type t :: %__MODULE__{
          id: number(),
          name: String.t(),
          use_condition: :worn_out | :brand_new
        }

  def new(attrs) do
    struct!(__MODULE__, attrs)
  end

  def is_worn_out(%__MODULE__{} = equipment) do
    equipment.use_condition == @condition_worn_out
  end

  def condition_worn_out do
    @condition_worn_out
  end

  def condition_brand_new do
    @condition_brand_new
  end
end
