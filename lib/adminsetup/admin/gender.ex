defmodule Adminsetup.Admin.Gender do
  use Ecto.Schema
  import Ecto.Changeset

  schema "genders" do
    field :gender, :string

    timestamps()
  end

  @doc false
  def changeset(gender, attrs) do
    gender
    |> cast(attrs, [:gender])
    |> validate_required([:gender])
  end
end
