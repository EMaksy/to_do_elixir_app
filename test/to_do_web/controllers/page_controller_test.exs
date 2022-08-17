defmodule ToDoWeb.PageControllerTest do
  use ToDoWeb.ConnCase

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "User entries exist?" do
    # user id
    test_id = 4
    entry_list = ToDoWeb.PageController.get_user_entries(test_id)
    empty_list = []
    assert entry_list != empty_list
  end
end
