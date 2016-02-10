defmodule Queue do
  use GenServer

  def push(pid, item) do
    GenServer.cast(pid, {:push, item})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  def count(pid) do
    GenServer.call(pid, :count)
  end

################################################################################
#################### Default GenServer Implementation ##########################
################################################################################

  def start_link(default) do
    GenServer.start_link(__MODULE__, default)
  end

  def handle_call(:pop, _from, [head|tail]) do
    {:reply, head, tail}
  end

  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end


  def handle_call(:count, _from, state) do
    {:reply, Enum.count(state), state}
  end

  def handle_cast({:push, item}, state) do
    new_state = state |> Enum.reverse([item]) |> Enum.reverse
    {:noreply, new_state}
  end
end
