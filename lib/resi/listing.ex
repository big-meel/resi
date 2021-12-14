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

    {:noreply, resolve_mapping(listing, details)}
  end

  defp resolve_mapping(listing, scraped_map) do
    listing
    |> Map.put(:address, scraped_map["Address"])
    |> Map.put(:parish, scraped_map["Area"])
    |> Map.put(:property_type, scraped_map["Property Type"])
    |> Map.put(:number_of_bedrooms, scraped_map["Bedrooms"])
    |> Map.put(:number_of_bathrooms, scraped_map["Bathrooms"])
    |> Map.put(:floor_space, scraped_map["Floor Space"])
    |> Map.put(:lot_size, scraped_map["Lot Size"])
    |> Map.put(:mls, scraped_map["MLS® #"])
    |> Map.put(:price_in_cents, scraped_map["Price"] ) # TODO: convert price to cents
  end
end
