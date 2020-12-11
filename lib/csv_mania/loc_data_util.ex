defmodule CsvMania.LocDataUtil do
  import CSV


  alias FutureMadeEvents.Repo
  alias FutureMadeEvents.Country
  alias FutureMadeEvents.City

  @path_to_countries_en "data/csv/en/country_locations.csv"
  @path_to_cities_en "data/csv/en/city_locations.csv"

  # wc -l  data/csv/en/<file_name>.csv
  @number_of_countries 253
  @number_of_cities 119523


  # desired fields on countries CSV
  @countries__geoname_id_index 0
  @countries__continent_name_index 3
  @countries__country_iso_code_index 4
  @countries__country_name_index 5
  @countries__is_in_eu_index 6

  # desired fields on cities CSV
  @cities__geoname_id_index 0
  @cities__continent_name_index 3
  @cities__country_name_index 5
  @cities__city_name_index 10
  @cities__time_zone_index 12
  @cities__is_in_eu_index 13

  def parse_countries_to_stream do
    @path_to_countries_en
    |> File.stream!
    |> CSV.decode
    |> Enum.take(@number_of_countries)
  end

  def parse_cities_to_stream do
    @path_to_cities_en
    |> File.stream!
    |> CSV.decode
    |> Enum.take(@number_of_cities)         # wc -l  >> data/csv/en/city_locations.csv :: 119523
  end

  # def get_country_tuples do

  #   # Enum.each(parse_to_stream(), fn country_tuple -> print_country_tuple(country_tuple) end)
  #   parse_to_stream()
  #   |> Enum.each(fn country_tuple -> extract_country_name(country_tuple) end)

  # end
  def write_countries do
    parse_countries_to_stream()
    |> Enum.each(fn country_tuple -> extract_country_details(country_tuple) end)
  end

  def write_cities do
    parse_cities_to_stream()
    |> Enum.each(fn city_tuple -> extract_city_details(city_tuple) end)
  end

  def extract_country_details(country_tuple) do
    {:ok, country_details} = country_tuple

    # some of the country names are empty in the CSV file.
    # also not adding the country_name tag on the first line of the file.

    geoname_id = Enum.at(country_details, @countries__geoname_id_index)
    country_name = Enum.at(country_details, @countries__country_name_index)

    unless country_name == "" or country_name == "country_name" do

      country_iso_code = Enum.at(country_details, @countries__country_iso_code_index)
      continent = Enum.at(country_details, @countries__continent_name_index)
      is_in_eu = Enum.at(country_details, @countries__is_in_eu_index)

      %Country{
        geoname_id: geoname_id,
        country_name: country_name,
        country_iso_code: country_iso_code,
        continent_name: continent,
        is_in_eu: is_in_eu
      }
    |> write_country_records()
    end

  end

  def extract_city_details(city_tuple) do
    {:ok, city_details} = city_tuple

    # some of the city names are empty in the CSV file.
    # also not adding the city_name tag on the first line of the file.

    geoname_id = Enum.at(city_details, @cities__geoname_id_index)
    city_name = Enum.at(city_details, @cities__city_name_index)

    unless city_name == "" or city_name == "city_name" do
      country_name = Enum.at(city_details, @cities__country_name_index)
      continent = Enum.at(city_details, @cities__continent_name_index)
      time_zone = Enum.at(city_details, @cities__time_zone_index)
      is_in_eu = Enum.at(city_details, @cities__is_in_eu_index)

      %City{
        geoname_id: geoname_id,
        city_name: city_name,
        country_name: country_name,
        continent_name: continent,
        time_zone: time_zone,
        is_in_eu: is_in_eu
      }
      |> write_city_records()
    end
  end

  def write_country_records(country) do
    Repo.insert!(country)
  end

  def write_city_records(city) do
    Repo.insert!(city)
  end

end
