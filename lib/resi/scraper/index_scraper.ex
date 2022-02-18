defmodule Resi.Scraper.IndexScraper do
  @raj_url "https://raj.xposureapp.com/"


  def get_list_of_ids(url \\ @raj_url) do
    url
    |> fetch_html()
    |> process_response()
  end

  # TODO: Add condition should nil or incorrect input be entered
  # TODO: Add Error Handling


  @spec process_response(binary)::list()
  def process_response(html) do
    {:ok, list_of_nodes} =
    Floki.parse_document(html)

    list_of_nodes
    |> Floki.find("script")
    |> List.last
    |> Floki.children
    |> List.first()
    |> process_raw_binary_to_ids()
    |> pluck_ids()
  end

  def process_raw_binary_to_ids(binary) do
    binary
    |> String.split("\"")
  end

  defp pluck_ids(list) do
      list
      |> Enum.filter( fn x -> String.match?(x, ~r/^\w{3,6}$/) end )
  end

  defp fetch_html(url) do
   {:ok, response} = HTTPoison.get(url)
   response.body
  end


end
