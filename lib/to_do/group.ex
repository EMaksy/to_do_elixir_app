defmodule ToDo.GROUP do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :group_name, :string
    field :user_group_id, :id

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:group_name])
    |> validate_required([:group_name])
  end

  def changeset(group, params \\ %{}) do
    cast(group, params, [:group_name])
  end
end
