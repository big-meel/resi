defmodule Resi.Listing do
  use GenServer

  alias Resi.Scraper.ListingScraper

  defstruct [
    :address,
    :parish,
    :property_type,
    :number_of_bedrooms,
    :number_of_bathrooms,
    :floor_space,
    :lot_size,
    :mls,
    :photo_links,
    :price_in_cents
  ]

  def init(init_state \\ %__MODULE__{}) do
    {:ok, init_state}
  end

  def handle_call(:show, _from, listing) do
    {:reply, listing, listing}
  end

  def handle_cast({:get_details, id}, listing) do
    details = ListingScraper.get_listing_details(id)

    {:noreply, Map.merge(listing, details)}
  end


end
