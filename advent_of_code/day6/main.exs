defmodule Main do
  def input do
    File.read!("./input.txt")
    |> String.trim()
    |> String.split("\n\n")
  end

  def call do
    input()
    |> Enum.map(fn x ->
      String.replace(x, "\n", "")
      |> String.graphemes
      |> Enum.uniq
      |> length
    end)
    |> Enum.sum
  end

  def call2 do
    input()
    |> Enum.map(fn x ->
      String.split(x, "\n")
      |> counti
      |> MapSet.size
    end)
    |> Enum.sum
  end

  def counti(l) do
    [first | rest] = l
    Enum.reduce(rest, String.graphemes(first) |> MapSet.new, fn x, acc ->
      v = String.graphemes(x) |> MapSet.new
      MapSet.intersection(v, acc)
    end)
  end
end
