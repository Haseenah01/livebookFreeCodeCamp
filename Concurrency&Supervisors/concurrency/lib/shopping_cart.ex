defmodule ShoppingCart do
  use GenServer

#Server callbacks
  def init(:ok) do
  {:ok, []}

  end

  def handle_cast({:add_to_cart, item}, list) do
    #list = list ++ [item]
    #{:noreply, list}
    #updated_list = [item | list]
    #{:noreply, updated_list}
    {:noreply, list ++ [item]}
  end

  def handle_cast({:remove_from_cart, item}, list ) do
    updated_list = Enum.reject(list, fn(i) -> i == item end)
    {:noreply, updated_list}
  end

  def handle_call(:get_cart, _from, list) do
    #[item | quantity] = list
    #{:reply, item, quantity}
    display_list = list
    |> Enum.frequencies()
    |> Map.to_list()
    {:reply, display_list, list}
  end

  #Client API
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def add_to_cart(pid, item) do
    GenServer.cast(pid, {:add_to_cart, item})
  end

  @spec remove_from_cart(atom | pid | {atom, any} | {:via, atom, any}, any) :: :ok
  def remove_from_cart(pid, item) do
    GenServer.cast(pid, {:remove_from_cart, item})
  end

  def get_cart(pid) do
    GenServer.call(pid, :get_cart)
  end
end
