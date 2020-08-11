defmodule Rumbl.Accounts do
  @moduledoc """
  This is the Accounts context
  """

  alias Rumbl.Accounts.User

  def list_users do
    [
      %User{id: "1", name: "Vinicius", username: "viniciusmmm"},
      %User{id: "2", name: "Laura", username: "laurap"},
      %User{id: "3", name: "Janete", username: "janete"}
    ]
  end

  def get_user(id) do
    Enum.find(list_users(), fn map -> map.id == id end)
  end

  def get_user_by(params) do
    Enum.find(list_users(), fn user ->
      Enum.all?(params, fn {key, val} -> Map.get(user, key) == val end)
    end)
  end
end
