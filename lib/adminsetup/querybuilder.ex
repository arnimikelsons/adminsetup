defmodule Adminsetup.QueryBuilder do
  import Ecto.Query

  def filter_by_name(query, params) do
    params[:name]
    |> case do
      nil -> query
      "" -> query
      text -> query |> where(from: ^text)
    end
  end
end
