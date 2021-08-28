defmodule ElixirLab.Repo.Migrations.CreateEquipments do
  use Ecto.Migration

  def change do
    create table(:equipments) do
      add :name, :string
      add :use_condition, :integer
    end
  end
end
