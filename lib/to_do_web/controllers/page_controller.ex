defmodule ToDoWeb.PageController do
  use ToDoWeb, :controller
  import Ecto.Query
  alias ToDoWeb.PageCounter

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def to_do(conn, _params) do
    # get id from session
    id = get_userid_from_conn(conn)
    # start agent for tracking
    PageCounter.start_link()
    entries = get_user_entries(id)
    changeset = ToDo.ENTRY.changeset(%ToDo.ENTRY{})
    render(conn, "to_do.html", id: id, entries: entries, changeset: changeset)
  end

  def add_entry(conn, params) do
    id = get_userid_from_conn(conn)
    entries = get_user_entries(id)
    PageCounter.increment_add()
    PageCounter.value() |> IO.inspect(label: "PageCounter value:")

    if params["entry"] != nil do
      entry_text = params["entry"] |> Map.values() |> Enum.at(0)
      new_entry = %{user_id: id, entry_text: entry_text, group_id: nil}
      changeset = ToDo.ENTRY.changeset(%ToDo.ENTRY{}, new_entry)
      # add to page counter

      case ToDo.Repo.insert(changeset) do
        {:ok, changeset} ->
          # render the updated to do list
          entries = get_user_entries(id)
          changeset = ToDo.ENTRY.changeset(%ToDo.ENTRY{})
          render(conn, "to_do.html", entries: entries, changeset: changeset)

        {:error, changeset} ->
          render(conn, "to_do.html", entries: entries, changeset: changeset)
      end
    else
      changeset = ToDo.ENTRY.changeset(%ToDo.ENTRY{})
      render(conn, "to_do.html", entries: entries, changeset: changeset)
    end
  end

  def delete_user_entry(conn, params) do
    # grab id from params
    params_id = Map.fetch(params, "entry") |> Tuple.to_list() |> tl |> Enum.at(0)
    entry_id = params_id["id"] |> String.to_integer()
    # get user id
    id = get_userid_from_conn(conn)
    # create a changeset
    changeset = ToDo.ENTRY.changeset(%ToDo.ENTRY{})
    # delete from database
    %ToDo.ENTRY{id: entry_id} |> ToDo.Repo.delete()
    # update html entries
    entries = get_user_entries(id)
    # render new page
    render(conn, "to_do.html", entries: entries, changeset: changeset)
  end

  def group(conn, _params) do
    render(conn, "group.html")
  end

  def end_session(conn, _params) do
    clear_session(conn)
    render(conn, "index.html")
  end

  @spec get_userid_from_conn(%{
          :assigns => %{
            :current_user => %{:id => any, optional(any) => any},
            optional(any) => any
          },
          optional(any) => any
        }) :: any
  def get_userid_from_conn(%{assigns: %{current_user: %{id: id}}}), do: id

  def get_user_entries(id) do
    # insert user id to show only user entries
    user_id = id

    query =
      from e in "entries",
        where: e.user_id == ^user_id,
        select: {e.entry_text, e.id}

    ToDo.Repo.all(query)
  end

  # def add_entry(conn, _paramas) do
  # IO.puts("Add entry was pressed")
  # get id from session
  # id = get_userid_from_conn(conn)
  # get user data from html
  # changeset = Entry.changeset(entry, attrs)
  # write user_entry to database

  # get entries from database
  #  entries = get_user_entries(id)
  #  render(conn, "to_do.html", entries: entries)
  # end
end
