defmodule ElixirLab.Lab.Adapter.Schema.Alchemist do
  use Ecto.Schema
  alias ElixirLab.Lab.Domain.Model.Alchemist

  schema "alchemists" do
    field(:name, :string)

    field(
      :level,
      Ecto.Enum,
      values: [{Alchemist.level_apprentice(), 0}, {Alchemist.level_master(), 1}]
    )
  end
end
