defmodule ToDo.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :crypted_password, :string
    field :email, :string
    field :name, :string
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :crypted_password])
    |> validate_required([:name, :email, :crypted_password])
    |> unique_constraint(:email)
    |> unique_constraint(:name)
  end
end
