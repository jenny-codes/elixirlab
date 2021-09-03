defmodule ElixirLab.Experiment.Model.ExperimentResult do
  alias ElixirLab.Experiment.Model.ExperimentCondition

  @type t :: %__MODULE__{
          condition: ExperimentCondition.t(),
          result: Atom
        }

  @enforce_keys [:condition, :result]
  defstruct [:condition, :result]

  def new(attrs) do
    struct!(__MODULE__, attrs)
  end

  def is_successful(exp) do
    exp.result == result_successful()
  end

  def result_successful() do
    :successful
  end

  def result_failed() do
    :failed
  end
end
