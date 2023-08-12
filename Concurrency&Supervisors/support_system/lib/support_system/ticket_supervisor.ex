defmodule SupportSystem.TicketSupervisor do
  use DynamicSupervisor

  def start_link(options \\ []) do
    DynamicSupervisor.start_link(__MODULE__, options, name: __MODULE__)
  end

  def init(_options) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def create_ticket(ticket_details) do
    spec = {SupportSystem.TicketWorker, ticket_details}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end
end
