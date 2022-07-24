defmodule Advent2020.Day7 do
  def input do
    Path.join(__DIR__, "../../priv/inputs/day7/input.txt")
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
  end

  def part1 do
    rules =
      input()
      |> Stream.map(&parse_rule/1)
      |> Enum.into(%{})

    graph = graph(rules)

    :digraph_utils.reaching_neighbours(["shiny gold"], graph)
    |> Enum.count()
  end

  def part2 do
    rules =
      input()
      |> Stream.map(&parse_rule/1)
      |> Enum.into(%{})

    graph = graph(rules)
    count_bags(graph, "shiny gold") - 1
  end

  defp count_bags(graph, vertex) do
    graph
    |> :digraph.out_edges(vertex)
    |> Enum.reduce(1, fn e, sum ->
      {^e, _, vertex, num} = :digraph.edge(graph, e)
      sum + num * count_bags(graph, vertex)
    end)
  end

  defp parse_rule(line) do
    [container, contents] = String.split(line, " bags contain ")
    {container, contents_to_map(contents)}
  end

  defp contents_to_map("no other bags.") do
    %{}
  end

  defp contents_to_map(contents) do
    contents
    |> String.trim_trailing(".")
    |> String.split(", ")
    |> Map.new(fn content ->
      [num, type] = String.split(content, " ", parts: 2)
      type = String.trim_trailing(type, " bags")
      type = String.trim_trailing(type, " bag")
      {type, String.to_integer(num)}
    end)
  end

  defp graph(map) do
    graph = :digraph.new([:acyclic, :private])

    for {v, _} <- map, do: :digraph.add_vertex(graph, v)

    for {from, contents} <- map, {to, num} <- contents do
      :digraph.add_edge(graph, from, to, num)
    end

    graph
  end

  # @input String
  # @return List
  def parse_children(children_string) when is_binary(children_string) do
    pattern = ~r"\d (.+) bag"

    children =
      String.split(children_string, ",")
      |> Enum.map(fn x ->
        bag_name =
          case Regex.run(pattern, x) do
            [_, bag_name] -> bag_name
            nil -> nil
          end

        case is_binary(bag_name) do
          true -> to_bag_name(bag_name)
          false -> nil
        end
      end)

    Enum.filter(children, &(!is_nil(&1)))
  end

  defp to_bag_name(bag_name) do
    String.split(bag_name, " ")
    |> Enum.join("_")
    |> String.to_atom()
  end
end
