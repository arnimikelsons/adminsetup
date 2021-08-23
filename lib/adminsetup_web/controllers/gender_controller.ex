defmodule AdminsetupWeb.GenderController do
  use AdminsetupWeb, :controller

  alias Adminsetup.Admin
  alias Adminsetup.Admin.Gender

  def index(conn, _params) do
    genders = Admin.list_genders()
    render(conn, "index.html", genders: genders)
  end

  def new(conn, _params) do
    changeset = Admin.change_gender(%Gender{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"gender" => gender_params}) do
    case Admin.create_gender(gender_params) do
      {:ok, gender} ->
        conn
        |> put_flash(:info, "Gender created successfully.")
        |> redirect(to: Routes.gender_path(conn, :show, gender))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    gender = Admin.get_gender!(id)
    render(conn, "show.html", gender: gender)
  end

  def edit(conn, %{"id" => id}) do
    gender = Admin.get_gender!(id)
    changeset = Admin.change_gender(gender)
    render(conn, "edit.html", gender: gender, changeset: changeset)
  end

  def update(conn, %{"id" => id, "gender" => gender_params}) do
    gender = Admin.get_gender!(id)

    case Admin.update_gender(gender, gender_params) do
      {:ok, gender} ->
        conn
        |> put_flash(:info, "Gender updated successfully.")
        |> redirect(to: Routes.gender_path(conn, :show, gender))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", gender: gender, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    gender = Admin.get_gender!(id)
    {:ok, _gender} = Admin.delete_gender(gender)

    conn
    |> put_flash(:info, "Gender deleted successfully.")
    |> redirect(to: Routes.gender_path(conn, :index))
  end
end
