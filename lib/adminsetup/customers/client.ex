defmodule Adminsetup.Customers.Client do
  use Ecto.Schema
  import Ecto.Changeset
  alias Adminsetup.Admin.Gender

  schema "clients" do
    field :location, :string
    field :name, :string

    belongs_to :genders, Gender

    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:name, :location, :genders_id])
    |> validate_required([:name, :location])
  end
end
