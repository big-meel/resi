defmodule Resi.Scraper.IndexScraper do
  @raj_url "https://raj.xposureapp.com/"

  def fetch_html do
    HTTPoison.get(@raj_url)
  end

  def get_ids do
    # Scrape html for ids
    # Return list of IDS
  end
end