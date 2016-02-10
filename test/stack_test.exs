defmodule QueueTest do
  use ExUnit.Case
  doctest Queue

  setup %{test: test} do
    {:ok, pid} = GenServer.start_link(Queue, [])
    {:ok, [pid: pid]}
  end

  test "starting without parameters returns a PID", %{pid: pid} do
    assert Process.alive?(pid)
  end

  test "Add a single element", %{pid: pid} do
    Queue.push(pid, :first_item)
    assert Queue.count(pid) == 1
  end

  test "Getting an element reduces the number of elements", %{pid: pid} do
    Queue.push(pid, :first_item)
    assert Queue.count(pid) == 1
    assert Queue.pop(pid) == :first_item
    assert Queue.count(pid) == 0
  end
end
