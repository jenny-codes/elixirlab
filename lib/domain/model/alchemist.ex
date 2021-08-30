defmodule ElixirLab.Domain.Model.Alchemist do
  @enforce_keys [:name, :level]
  defstruct [:id, :name, :level]
  @level_apprentice :apprentice
  @level_master :master

  def new(attrs) do
    struct!(__MODULE__, attrs)
  end

  def is_apprentice(%__MODULE__{} = alchemist) do
    alchemist.level == @level_apprentice
  end

  def level_master do
    @level_master
  end

  def level_apprentice do
    @level_apprentice
  end
end
