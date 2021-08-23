defmodule Adminsetup.CustomersTest do
  use Adminsetup.DataCase

  alias Adminsetup.Customers

  describe "clients" do
    alias Adminsetup.Customers.Client

    @valid_attrs %{gender: "some gender", location: "some location", name: "some name"}
    @update_attrs %{gender: "some updated gender", location: "some updated location", name: "some updated name"}
    @invalid_attrs %{gender: nil, location: nil, name: nil}

    def client_fixture(attrs \\ %{}) do
      {:ok, client} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Customers.create_client()

      client
    end

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Customers.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Customers.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      assert {:ok, %Client{} = client} = Customers.create_client(@valid_attrs)
      assert client.gender == "some gender"
      assert client.location == "some location"
      assert client.name == "some name"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customers.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      assert {:ok, %Client{} = client} = Customers.update_client(client, @update_attrs)
      assert client.gender == "some updated gender"
      assert client.location == "some updated location"
      assert client.name == "some updated name"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Customers.update_client(client, @invalid_attrs)
      assert client == Customers.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Customers.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Customers.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Customers.change_client(client)
    end
  end
end
