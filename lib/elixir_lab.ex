defmodule ElixirLab do
  alias ElixirLab.Experiment
  alias ElixirLab.Notification

  @callback run_experiment(number(), [String.t()]) :: String.t()
  def run_experiment(alchemist_id, materials) do
    result = Experiment.run(alchemist_id, materials)

    Notification.notify_experiment_result(alchemist_id, result)

    result
  end
end
