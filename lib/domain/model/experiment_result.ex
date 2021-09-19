defmodule ElixirLab.Domain.Model.ExperimentResult do
  alias ElixirLab.Domain.Model.ExperimentCondition

  @enforce_keys [:condition, :result]
  defstruct [:condition, :result]

  @spec new(condition: ExperimentCondition.t(), result: Atom) :: struct()
  def new(attrs) do
    struct!(__MODULE__, attrs)
  end

  def is_successful(exp_result) do
    exp_result.result == result_successful()
  end

  def result_successful() do
    :successful
  end

  def result_failed() do
    :failed
  end
end
