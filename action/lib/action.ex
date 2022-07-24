defmodule Action do
  @moduledoc """
  Documentation for `Action`.
  """

  def main do
    TodoList.new()
    |> TodoList.add_entry(~D[2022-01-20], "Do laundry")
    |> TodoList.add_entry(~D[2022-01-21], "Clean the floor")
    |> TodoList.add_entry(~D[2022-01-22], "Movies")
  end
end
