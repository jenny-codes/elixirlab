defmodule ElixirLab.Lab.Adapter.Schema.Experiment do
  use Ecto.Schema

  schema "experiments" do
    field(:alchemist_id, :id)
    field(:equipment_id, :id)
    field(:materials, :string)
    field(:result, :string)
  end
end
