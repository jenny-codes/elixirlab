import Config

experiment_repo =
  if config_env() == :test do
    ElixirLab.Lab.MockExperimentRepo
  else
    ElixirLab.Lab.Adapter.EexperimentRepo
  end

config :elixir_lab, experiment_repo: experiment_repo
