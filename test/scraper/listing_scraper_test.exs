defmodule Resi.Scraper.ListingScraperTest do
  use ExUnit.Case, async: true

  alias Resi.Scraper.ListingScraper, as: Scraper

  @id "1upgs"

  setup do
    details = Scraper.fetch_listing_html(@id)
    |> Scraper.list_nodes()
    |> Scraper.fetch_details()

    {:ok, details: details}
  end

  describe "Scraper.fetch_details/1" do


    test "with valid id gets a map containing details", context do
      assert is_map(context[:details])
      assert Map.has_key? context[:details], "Address"
    end

  end

  # TODO: Make notes and do research on what to test and how to handle errors

end
