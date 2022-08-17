defmodule ToDo.USER_GROUP do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_groups" do
    field :user_counter, :integer
    field :user_id, :id
    field :group_id, :id
    timestamps()
  end

  @doc false
  def changeset(user_group, attrs) do
    user_group
    |> cast(attrs, [:user_counter])
    |> validate_required([:user_counter])
  end
end
