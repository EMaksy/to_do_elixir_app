defmodule ToDo.Repo.Migrations.AddTables do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add(:entry_text, :string)

      timestamps()
    end

    create table(:groups) do
      add :group_name, :text

      timestamps()
    end

    create table(:user_groups) do
      add :user_counter, :integer

      timestamps()
    end

    alter table(:user_groups) do
      add(:user_id, references(:users, on_delete: :delete_all))
      add(:goup_id, references(:groups, on_delete: :delete_all))
    end

    alter table(:entries) do
      add(:user_id, references(:users, on_delete: :delete_all))
    end

    alter table(:groups) do
      add(:user_group_id, references(:user_groups, on_delete: :delete_all))
    end
  end
end
