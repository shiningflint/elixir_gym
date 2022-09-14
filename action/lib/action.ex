defmodule Action do
  @moduledoc """
  Documentation for `Action`.
  """

  def main do
    TodoList.new()
    |> TodoList.add_entry(%{date: ~D[2022-01-20], title: "Do laundry"})
    |> TodoList.add_entry(%{date: ~D[2022-01-21], title: "Clean the floor"})
    |> TodoList.add_entry(%{date: ~D[2022-01-21], title: "Watch TeeVee"})
    |> TodoList.add_entry(%{date: ~D[2022-01-22], title: "Movies"})
  end

  def entries do
    [
      %{date: ~D[2022-01-22], title: "Do kentang"},
      %{date: ~D[2022-01-22], title: "Do potato"},
      %{date: ~D[2022-01-22], title: "Do bananas"}
    ]
  end
end
