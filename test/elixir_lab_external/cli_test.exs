defmodule ElixirLabExternal.CLITest do
  use ExUnit.Case, async: true
  alias ElixirLabExternal.CLI

  import ExUnit.CaptureIO
  import Mox

  test "format submit command and print result" do
    expected_input_materials = ["egg", "phoenix ash", "gum"]

    MockElixirLab
    |> expect(:run_experiment, fn 1, ^expected_input_materials ->
      "elixir!"
    end)

    result =
      capture_io(fn ->
        CLI.main(["submit", "--aid", "1", "--materials", Enum.join(expected_input_materials, ",")])
      end)

    assert result == "elixir!\n"
  end
end
