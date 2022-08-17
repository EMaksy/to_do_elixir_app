defmodule ToDoWeb.GroupController do
  use ToDoWeb, :controller
  import Ecto.Query

  @error nil

  def index(conn, _params) do
    group_names = get_all_group_names()
    render(conn, "group.html", group_names: group_names)
  end

  def get_all_group_names() do
    query = from g in "groups", select: {g.group_name}
    IO.inspect(query)
    result = ToDo.Repo.all(query)
    IO.inspect(result)
    result
  end

  def new(conn, _params) do
    users = list_all_users()
    changeset = ToDo.GROUP.changeset(%ToDo.GROUP{}, %{})
    IO.inspect(users)
    # error message

    render(conn, "new.html", users: users, changeset: changeset, error: @error)
  end

  def create_group_db(group_name) do
    user_group_id = 1
    new_group = %{group_name: group_name, user_group_id: user_group_id}
    IO.inspect(new_group)
    changeset = ToDo.GROUP.changeset(%ToDo.GROUP{}, new_group)
    IO.inspect(changeset)
    ToDo.Repo.insert(changeset)
  end

  def create(conn, params) do
    # get group name from params
    IO.inspect(params)
    group_name = params["group"] |> Map.fetch("group_name") |> elem(1)
    IO.inspect(group_name)

    # get count of users
    if group_name == "" or Enum.count(params) < 3 do
      # create composed user group in database
      changeset = ToDo.GROUP.changeset(%ToDo.GROUP{})
      users = list_all_users()
      error = "A Group Name is required and at least one user needs to be selected"
      IO.puts("Counter:")
      IO.inspect(Enum.count(params))

      render(conn, "new.html",
        changeset: changeset,
        users: users,
        error: error
      )
    else
      changeset = create_group_db(group_name)
      group_names = get_all_group_names()
      render(conn, "group.html", changeset: changeset, group_names: group_names)
    end
  end

  def list_all_users() do
    # html equivalent
    # <%= for user <- @users do %>
    # <p><%= user |> Tuple.to_list |> Enum.join %></p>
    # <% end %>
    query = from u in "users", select: {u.email}
    ToDo.Repo.all(query)
  end
end
