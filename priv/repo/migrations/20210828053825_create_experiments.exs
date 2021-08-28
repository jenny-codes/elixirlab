defmodule ElixirLab.Repo.Migrations.CreateExperiments do
  use Ecto.Migration

  def change do
    create table(:experiments) do
      add :alchemist_id, references(:alchemists, null: false)
      add :equipment_id, references(:equipments, null: false)
      add :materials, :string
      add :result, :string
    end
  end
end
