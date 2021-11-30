defmodule Resi.Scraper.IndexScraper do
  @raj_url "https://raj.xposureapp.com/"


  def get_list_of_ids() do
    fetch_html()
    |> parse_response()
    |> get_id_script()
    |> get_raw_id_binary()
  end

  defp fetch_html() do
   case HTTPoison.get(@raj_url) do
    {:ok, response} ->
      response.body
    {:error, reason} ->
      reason
   end
  end

  defp parse_response(html) do
    case Floki.parse_document(html) do
      {:ok, list_of_nodes} ->
        list_of_nodes
      {:error, reason} ->
        reason
    end
  end

  defp get_id_script(node_list) do
    Floki.find(node_list, "script")
  end

  defp get_raw_id_binary(node) do
    node
    |> List.last
    |> Floki.children
  end
end
