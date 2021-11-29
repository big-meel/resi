defmodule Resi.Scraper.ListingScraper do
  @listings_url "https://raj.xposureapp.com/listing/"

  def fetch_listing_html(id) do
    HTTPoison.get( format_url(id) )
  end

  # Add methods to get listing information from html

  defp format_url(id) do
    "#{@listings_url}#{id}"
  end

end
