defmodule ElixirLab.Repo.Migrations.CreateAlchemists do
  use Ecto.Migration

  def change do
    create table(:alchemists) do
      add :name, :string
      add :level, :integer
    end
  end
end
