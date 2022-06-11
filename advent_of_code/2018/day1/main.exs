defmodule Main do
  def input do
    File.read!("./input.txt")
    |> String.trim()
    |> String.split("\n")
  end

  def call do
    input()
    |> Enum.map(fn n -> String.to_integer(n) end)
    |> Enum.reduce(fn (number, sum) -> sum + number end)
  end

  def call2 do
    IO.inspect(Enum.count(input()))


    input()
    |> Enum.map(fn n -> String.to_integer(n) end)
    |> Stream.cycle
    |> Enum.reduce_while({0, MapSet.new([0])}, fn move, {current, seen} ->
      new = move + current

      cond do
        MapSet.member?(seen, new) -> {:halt, new}
        true -> {:cont, {new, MapSet.put(seen, new)}}
      end
    end)
  end

  def call2_me do
    # input()
    # |> Enum.map(fn n -> String.to_integer(n) end)
    # [3, 3, 4, -2, -4]
    input()
    |> Enum.map(fn n -> String.to_integer(n) end)
    |> List.duplicate(142)
    |> List.flatten
    |> Enum.reduce([0], fn n, acc ->
      sum = n + List.last(acc)
      Enum.concat(acc, [sum])
    end)
    |> Enum.map(fn x -> Integer.to_string(x) end)
    |> gd
  end

  def gd (list) do
    list
    |> Enum.group_by(&(&1))
    # |> Enum.filter(fn {_, [_,_|_]} -> true; _ -> false end)
    |> Enum.filter(&match?({_, [_, _ | _]}, &1))
    |> Enum.map(fn {x, _} -> x end)
  end

  def duplicates(list) do
    acc_dupes = fn(x, {elems, dupes}) ->
      case Map.has_key?(elems, x) do
        true -> {elems, Map.put(dupes, x, nil)}
        false -> {Map.put(elems, x, nil), dupes}
      end
    end

    list |> Enum.reduce({%{}, %{}}, acc_dupes) |> elem(1) |> Map.keys()
  end
end
