defmodule AdminsetupWeb.GenderControllerTest do
  use AdminsetupWeb.ConnCase

  alias Adminsetup.Admin

  @create_attrs %{gender: "some gender"}
  @update_attrs %{gender: "some updated gender"}
  @invalid_attrs %{gender: nil}

  def fixture(:gender) do
    {:ok, gender} = Admin.create_gender(@create_attrs)
    gender
  end

  describe "index" do
    test "lists all genders", %{conn: conn} do
      conn = get(conn, Routes.gender_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Genders"
    end
  end

  describe "new gender" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.gender_path(conn, :new))
      assert html_response(conn, 200) =~ "New Gender"
    end
  end

  describe "create gender" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.gender_path(conn, :create), gender: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.gender_path(conn, :show, id)

      conn = get(conn, Routes.gender_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Gender"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.gender_path(conn, :create), gender: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Gender"
    end
  end

  describe "edit gender" do
    setup [:create_gender]

    test "renders form for editing chosen gender", %{conn: conn, gender: gender} do
      conn = get(conn, Routes.gender_path(conn, :edit, gender))
      assert html_response(conn, 200) =~ "Edit Gender"
    end
  end

  describe "update gender" do
    setup [:create_gender]

    test "redirects when data is valid", %{conn: conn, gender: gender} do
      conn = put(conn, Routes.gender_path(conn, :update, gender), gender: @update_attrs)
      assert redirected_to(conn) == Routes.gender_path(conn, :show, gender)

      conn = get(conn, Routes.gender_path(conn, :show, gender))
      assert html_response(conn, 200) =~ "some updated gender"
    end

    test "renders errors when data is invalid", %{conn: conn, gender: gender} do
      conn = put(conn, Routes.gender_path(conn, :update, gender), gender: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Gender"
    end
  end

  describe "delete gender" do
    setup [:create_gender]

    test "deletes chosen gender", %{conn: conn, gender: gender} do
      conn = delete(conn, Routes.gender_path(conn, :delete, gender))
      assert redirected_to(conn) == Routes.gender_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.gender_path(conn, :show, gender))
      end
    end
  end

  defp create_gender(_) do
    gender = fixture(:gender)
    %{gender: gender}
  end
end
