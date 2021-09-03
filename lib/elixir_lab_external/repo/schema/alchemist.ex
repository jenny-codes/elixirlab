defmodule ElixirLabExternal.Repo.Schema.User do
  use Ecto.Schema
  alias ElixirLab.Experiment.Model.Alchemist

  schema "users" do
    field(:name, :string)

    field(
      :level,
      Ecto.Enum,
      values: [{Alchemist.level_apprentice(), 0}, {Alchemist.level_master(), 1}]
    )
  end
end
