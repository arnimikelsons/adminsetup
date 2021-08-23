defmodule AdminsetupWeb.ClientController do
  use AdminsetupWeb, :controller

  alias Adminsetup.Customers
  alias Adminsetup.Customers.Client
  alias Adminsetup.CSV.Builder

  def index(conn, params) do
    clients = Customers.list_clients_filter(params)
    render(conn, "index.html", clients: clients)
  end

  def new(conn, _params) do
    changeset = Customers.change_client(%Client{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"client" => client_params}) do
    case Customers.create_client(client_params) do
      {:ok, client} ->
        conn
        |> put_flash(:info, "Client created successfully.")
        |> redirect(to: Routes.client_path(conn, :show, client))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    client = Customers.get_client!(id)
    render(conn, "show.html", client: client)
  end

  def export(conn, _params) do
    clients = Customers.list_clients_csv()

    send_download(
      conn,
      {:binary, Builder.to_csv([:id, :location, :name, :gender], clients)},
      content_type: "application/csv",
      filename: "client-data.csv"
    )
  end

  def edit(conn, %{"id" => id}) do
    client = Customers.get_client!(id)
    changeset = Customers.change_client(client)
    render(conn, "edit.html", client: client, changeset: changeset)
  end

  def update(conn, %{"id" => id, "client" => client_params}) do
    client = Customers.get_client!(id)

    case Customers.update_client(client, client_params) do
      {:ok, client} ->
        conn
        |> put_flash(:info, "Client updated successfully.")
        |> redirect(to: Routes.client_path(conn, :show, client))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", client: client, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    client = Customers.get_client!(id)
    {:ok, _client} = Customers.delete_client(client)

    conn
    |> put_flash(:info, "Client deleted successfully.")
    |> redirect(to: Routes.client_path(conn, :index))
  end
end
