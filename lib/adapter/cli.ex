defmodule ElixirLab.Adapter.CLI do
  alias ElixirLab.UseCase.RunExperiment

  @experiment_repo Application.compile_env!(:elixir_lab, :experiment_repo)

  def main(args \\ []) do
    args
    |> parse_args
    |> response
    |> IO.puts()
  end

  defp parse_args(args) do
    {params, [action], _} = OptionParser.parse(args, strict: [materials: :string, aid: :integer])

    {action, params}
  end

  defp response({"submit", [aid: alchemist_id, materials: material_str]}) do
    materials = String.split(material_str, ",")
    RunExperiment.call(alchemist_id, materials, @experiment_repo)
  end
end
