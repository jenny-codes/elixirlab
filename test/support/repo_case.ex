defmodule ElixirLab.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias ElixirLab.Repo

      import Ecto
      import Ecto.Query
      import ElixirLab.RepoCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ElixirLab.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(ElixirLab.Repo, {:shared, self()})
    end

    :ok
  end
end
