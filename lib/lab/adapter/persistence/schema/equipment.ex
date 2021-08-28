defmodule ElixirLab.Lab.Adapter.Schema.Equipment do
  use Ecto.Schema
  alias ElixirLab.Lab.Domain.Model.Equipment

  schema "equipments" do
    field(:name, :string)

    field(
      :use_condition,
      Ecto.Enum,
      values: [{Equipment.condition_brand_new(), 0}, {Equipment.condition_worn_out(), 1}]
    )
  end
end
