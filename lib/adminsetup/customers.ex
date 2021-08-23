defmodule Adminsetup.Customers do
  @moduledoc """
  The Customers context.
  """

  import Ecto.Query, warn: false
  alias Adminsetup.Repo
  alias Adminsetup.Admin.Gender
  alias Adminsetup.Customers.Client

  @doc """
  Returns the list of clients.

  ## Examples

      iex> list_clients()
      [%Client{}, ...]

  """
  def list_clients do
    Client
    |> Repo.all()
    |> Repo.preload(:genders)
  end

  @doc """
  Returns the list of clients.

  ## Examples

      iex> list_clients_filter()
      [%Client{}, ...]

  """
  def list_clients_filter(params) do
    search_name = "%#{get_in(params, ["name"])}%"
    search_location = "%#{get_in(params, ["location"])}%"

    sort_order =
      case get_in(params, ["sort_by"]) do
        "name" -> :name
        "location" -> :location
        nil -> :name
      end

    query =
      from c in Client,
        where: ilike(c.name, ^search_name),
        where: ilike(c.location, ^search_location),
        order_by: ^sort_order

    query
    |> Repo.all()
    |> Repo.preload(:genders)
  end

  def search(query, search_term) do
    wildcard_search = "%#{search_term}%"

    from c in query,
      where: ilike(c.name, ^wildcard_search)
  end

  @doc """
  Returns the list of clients.

  ## Examples

      iex> list_clients()
      [%Client{}, ...]

  """
  def list_clients_filter_bk(client_query, name_filter, location_filter, sort_order) do
    client_query = Client
    name_filter = "%#{""}%"
    location_filter = "%#{""}%"
    sort_order = :name

    query =
      from c in client_query,
        where: ilike(c.name, ^name_filter),
        where: ilike(c.location, ^location_filter),
        order_by: ^sort_order

    query
    |> Repo.all()
    |> Repo.preload(:genders)
  end

  @doc """
  Returns the list of clients.

  ## Examples

      iex> list_clients()
      [%Client{}, ...]

  """
  def list_clients_csv do
    query =
      from c in Client,
        join: g in Gender,
        on: g.id == c.genders_id,
        select: %{id: c.id, name: c.name, location: c.location, gender: g.gender}

    query
    |> Repo.all()
  end

  @doc """
  Gets a single client.

  Raises `Ecto.NoResultsError` if the Client does not exist.

  ## Examples

      iex> get_client!(123)
      %Client{}

      iex> get_client!(456)
      ** (Ecto.NoResultsError)

  """
  def get_client!(id) do
    Client
    |> Repo.get!(id)
    |> Repo.preload(:genders)
  end

  @doc """
  Creates a client.

  ## Examples

      iex> create_client(%{field: value})
      {:ok, %Client{}}

      iex> create_client(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_client(attrs \\ %{}) do
    %Client{}
    |> Client.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a client.

  ## Examples

      iex> update_client(client, %{field: new_value})
      {:ok, %Client{}}

      iex> update_client(client, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_client(%Client{} = client, attrs) do
    client
    |> Client.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a client.

  ## Examples

      iex> delete_client(client)
      {:ok, %Client{}}

      iex> delete_client(client)
      {:error, %Ecto.Changeset{}}

  """
  def delete_client(%Client{} = client) do
    Repo.delete(client)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking client changes.

  ## Examples

      iex> change_client(client)
      %Ecto.Changeset{data: %Client{}}

  """
  def change_client(%Client{} = client, attrs \\ %{}) do
    Client.changeset(client, attrs)
  end
end
