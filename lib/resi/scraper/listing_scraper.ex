defmodule Resi.Scraper.ListingScraper do
  @listings_url "https://raj.xposureapp.com/listing/"

  def fetch_listing_html(id) do
    {:ok, response} = HTTPoison.get( format_url(id) )

    response.body
  end

  @spec fetch_image_urls(binary)::list()
  def fetch_image_urls(nodes) do
    nodes
    |> Floki.find(".rsImg")
    |> Floki.attribute("a", "href")
  end

  @spec fetch_details(binary) :: [binary]
  def fetch_details(nodes) do
    nodes
    |> Floki.find(".detail-tab-content")
    |> List.last()
    |> Floki.find("td")
    |> Enum.map(&Floki.children(&1))
    |> Enum.map_every(2, fn x -> Floki.children( List.first(x) ) end)
    |> compress_to_map()

  end

  @spec list_nodes(binary)::[ binary ]
  def list_nodes(html) do
    {:ok, list} = Floki.parse_document(html)

    list
  end

  defp format_url(id) do
    "#{@listings_url}#{id}"
  end

  def compress_to_map(list, map_list \\ %{})
  def compress_to_map(list, map_list) when list == [], do: map_list
  def compress_to_map(list, map_list) do
   [hd | tail] = list
   Map.put(map_list, hd, List.first(tail))

   compress_to_map(tail, map_list)
  end
end
