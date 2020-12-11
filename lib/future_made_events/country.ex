defmodule FutureMadeEvents.Country do
  use Ecto.Schema


#   {:ok,
#   ["geoname_id", "locale_code", "continent_code", "continent_name", "country_iso_code", "country_name", "is_in_european_union"]}
#  {:ok, ["49518", "en", "AF", "Africa", "RW", "Rwanda", "0"]}

# continent name ->3
# country_iso_code ->5
# country_name ->6
# is_in_european_union -> 7



  schema "countries" do
    field :geoname_id, :string
    field :country_name, :string
    field :country_iso_code, :string
    field :continent_name, :string
    field :is_in_eu, :string

    timestamps()
  end

  # //TODO: add releases
  # defmodule Release do
  #   defstruct musician: "" , album: "", year: "", label: ""
  # end

end
