defmodule Adminsetup.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :name, :string
      add :location, :string
      add :gender, :string

      timestamps()
    end

  end
end
