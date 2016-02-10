defmodule SuperviseProcess do
  use Supervisor

   def start_link(name \\ nil) do
    Supervisor.start_link(__MODULE__, [], name: name)
  end

  def init(_params) do
    queues = [
      worker(Queue, [])
    ]
    supervise(queues, strategy: :one_for_one)
  end
end
