defmodule ElixirLab.Adapter.Store.Schema.Experiment do
  use Ecto.Schema

  schema "experiments" do
    field(:user_id, :id)
    field(:equipment_id, :id)
    field(:materials, :string)
    field(:result, :string)
  end
end
