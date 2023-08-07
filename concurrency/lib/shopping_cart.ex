defmodule ShoppingCart do
  use GenServer

#Server callbacks
  def init(:ok) do
  {:ok, []}

  end

  def handle_cast({:add_to_cart, item, quantity}, list) do
    #list = list ++ [item]
    #{:noreply, list}
    #updated_list = [item | list]
    #{:noreply, updated_list}
    {:noreply, list ++ [{item, quantity}]}
  end

  def handle_cast({:remove_from_cart, item, quantity}, list ) do
    updated_list = Enum.reject(list, fn(i) -> i == {item, quantity} end)
    {:noreply, updated_list}
  end

  def handle_call(:get_cart, _from, list) do
    #[item | quantity] = list
    #{:reply, item, quantity}
    {:reply, list, list}
  end

  #Client API
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def add_to_cart(pid, item, quantity) do
    GenServer.cast(pid, {:add_to_cart, item, quantity})
  end

  def remove_from_cart(pid, item, quantity) do
    GenServer.cast(pid, {:remove_from_cart, item, quantity})
  end

  def get_cart(pid) do
    GenServer.call(pid, :get_cart)
  end
end
