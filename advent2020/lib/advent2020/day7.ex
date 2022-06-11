defmodule Advent2020.Day7 do
  def input do
    Path.join(__DIR__, "day7/input_small.txt")
    |> File.read!
    |> String.trim()
    |> String.split("\n")
  end

  def part1 do
    :bananas
  end

  def parse_rule(line) do
    [parent | child] = String.split(line, " bags contain")

    case Enum.count(child) > 0 do
      true ->
        { :ok, to_bag_name(parent) }
      _ ->
        { :error, "bad rule" }
    end
  end

  # @input String
  # @return List
  def parse_children(children_string) when is_binary(children_string) do
    pattern = ~r"\d (.+) bag"

    children = String.split(children_string, ",")
               |> Enum.map(fn x ->
                 bag_name = case Regex.run(pattern, x) do
                   [_, bag_name] -> bag_name
                   nil -> nil
                 end
                 case is_binary(bag_name) do
                   true -> to_bag_name(bag_name)
                   false -> nil
                 end
               end)

    Enum.filter(children, & !is_nil(&1))
  end

  defp to_bag_name(bag_name) do
    String.split(bag_name, " ")
    |> Enum.join("_")
    |> String.to_atom
  end
end
