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

end
