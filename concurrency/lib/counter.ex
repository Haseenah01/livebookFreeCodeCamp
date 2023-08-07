defmodule Counter do
  use GenServer

  # Server Callbacks

  def init(initial_count) do
    {:ok, initial_count}
  end

  def handle_cast(:increment, count) do
    {:noreply, count + 1}
  end

  def handle_cast(:decrement, count) do
    {:noreply, count - 1}
  end

  def handle_call(:get_count, _from, count) do
    {:reply, count, count}
  end

  # Client API

  def start_link(initial_count \\ 0) do
    GenServer.start_link(__MODULE__, initial_count, name: __MODULE__)
  end

  def increment do
    GenServer.cast(__MODULE__, :increment)
  end

  def decrement do
    GenServer.cast(__MODULE__, :decrement)
  end

  def get_count do
    GenServer.call(__MODULE__, :get_count)
  end
end
