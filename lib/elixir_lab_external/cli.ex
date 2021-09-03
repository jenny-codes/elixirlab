defmodule ElixirLabExternal.CLI do
  @elixir_lab_module Application.compile_env(:elixir_lab, :elixir_lab, ElixirLab)

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
    @elixir_lab_module.run_experiment(alchemist_id, materials)
  end
end
