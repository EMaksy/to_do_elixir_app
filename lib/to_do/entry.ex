defmodule ToDo.ENTRY do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :user_id, :id
    field :group_id, :id
    field :entry_text, :string

    timestamps()
  end

  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:user_id, :entry_text])
    |> validate_required([:user_id, :entry_text])
  end

  def changeset(entry, params \\ %{}) do
    cast(entry, params, [:user_id, :entry_text])
  end
end
