defmodule Adminsetup.AdminTest do
  use Adminsetup.DataCase

  alias Adminsetup.Admin

  describe "genders" do
    alias Adminsetup.Admin.Gender

    @valid_attrs %{gender: "some gender"}
    @update_attrs %{gender: "some updated gender"}
    @invalid_attrs %{gender: nil}

    def gender_fixture(attrs \\ %{}) do
      {:ok, gender} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_gender()

      gender
    end

    test "list_genders/0 returns all genders" do
      gender = gender_fixture()
      assert Admin.list_genders() == [gender]
    end

    test "get_gender!/1 returns the gender with given id" do
      gender = gender_fixture()
      assert Admin.get_gender!(gender.id) == gender
    end

    test "create_gender/1 with valid data creates a gender" do
      assert {:ok, %Gender{} = gender} = Admin.create_gender(@valid_attrs)
      assert gender.gender == "some gender"
    end

    test "create_gender/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_gender(@invalid_attrs)
    end

    test "update_gender/2 with valid data updates the gender" do
      gender = gender_fixture()
      assert {:ok, %Gender{} = gender} = Admin.update_gender(gender, @update_attrs)
      assert gender.gender == "some updated gender"
    end

    test "update_gender/2 with invalid data returns error changeset" do
      gender = gender_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_gender(gender, @invalid_attrs)
      assert gender == Admin.get_gender!(gender.id)
    end

    test "delete_gender/1 deletes the gender" do
      gender = gender_fixture()
      assert {:ok, %Gender{}} = Admin.delete_gender(gender)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_gender!(gender.id) end
    end

    test "change_gender/1 returns a gender changeset" do
      gender = gender_fixture()
      assert %Ecto.Changeset{} = Admin.change_gender(gender)
    end
  end
end
