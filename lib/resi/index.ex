defmodule Resi.Index do
  use GenServer

  alias Resi.Scraper.IndexScraper

  def init(init_state \\ []) do
    {:ok, init_state}
  end

  def handle_call(:show, _from, index) do
    {:reply, index, index}
  end

  def handle_cast(:get_ids, _index) do
    list = IndexScraper.get_list_of_ids()

    {:noreply, list }
  end

  # API

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [])
  end

  def show(pid) do
    GenServer.call(pid, :show)
  end

  def get_ids(pid) do
    GenServer.cast(pid, :get_ids)
  end

end
