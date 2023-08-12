defmodule SupportSystem.TicketWorker do
  use GenServer

  def start_link(ticket) do
    GenServer.start_link(__MODULE__, ticket)
  end

  def init(ticket) do
    {:ok, ticket}
  end

  def handle_call(:assign_agent, _from, ticket) do
    assigned_ticket = Map.put(ticket, :status, :assigned)
    {:reply, :ok, assigned_ticket}
  end

  def handle_call(:resolve, _from, ticket) do
    resolved_ticket = Map.put(ticket, :status, :resolved)
    {:reply, :ok, resolved_ticket}
  end
end
