defmodule ToDoWeb.PageCounter do
  use Agent
  require IEx

  @module_name __MODULE__

  def start_link() do
    Agent.start_link(fn -> %{add: 0} end, name: __MODULE__)
  end

  def value do
    Agent.get(__MODULE__, & &1)
  end

  def increment_add do
    # Agent.update(@module_name, fn state -> %{add: state[:add] + 1} end)
    Agent.update(@module_name, &%{add: &1[:add] + 1})
  end

  def increment do
    Agent.update(@module_name, &(&1 + 1))
  end

  def decrement do
    Agent.update(@module_name, &(&1 - 1))
  end

  def stop_agent do
    Agent.stop(@module_name)
  end
end
