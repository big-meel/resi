defmodule Resi.Scraper.ListingScraper do
  @listings_url "https://raj.xposureapp.com/listing/"

  def fetch_listing_html(url) do
    HTTPoison.get(url)
  end

  defp format_url(id) do
    "#{@listings_url}#{id}"
  end

end
