defmodule Adminsetup.Repo.Migrations.AddReferenceToClients do
  use Ecto.Migration

  def change do
    alter table(:clients) do
      add :genders_id, references("genders")
      remove :gender
    end
  end
end
