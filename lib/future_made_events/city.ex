defmodule FutureMadeEvents.City do
  use Ecto.Schema


  # 301911,en,AS,Asia,TR,Turkey,03,Afyonkarahisar,,,Sandikli,,Europe/Istanbul,0

  # Field -> field_index_at_line  >>> Enum.at(field_index_at_line)

  # geoname_id,
  # locale_code,
  # continent_code,
  # continent_name, -> 3
  # country_iso_code,
  # country_name, -> 5
  # subdivision_1_iso_code,
  # subdivision_1_name,
  # subdivision_2_iso_code,
  # subdivision_2_name,
  # city_name -> 10
  # metro_code,
  # time_zone, -> 12
  #is_in_european_union ->13


  schema "cities" do
    field :geoname_id, :string
    field :city_name, :string
    field :country_name, :string
    field :continent_name, :string
    field :time_zone, :string
    field :is_in_eu, :string

    timestamps()

  end

  # //TODO: add releases
  # defmodule Release do
  #   defstruct musician: "" , album: "", year: "", label: ""
  # end

end
