defmodule ElixirLab.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :level, :integer
    end
  end
end
