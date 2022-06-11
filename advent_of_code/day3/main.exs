defmodule Main do
  def input do
    File.read!("./input_small.txt")
    |> String.trim()
    |> String.split("\n")
  end

  def call do
    input()
    |> Stream.with_index
    |> get_trees
  end

  def call2 do
    input()
    |> Stream.with_index
    |> Stream.filter(fn { _, index } ->
      rem(index, 2) == 0
    end)
    |> Stream.map(fn n -> elem(n, 0) end)
    |> Stream.with_index
    |> get_trees
  end

  defp get_trees(enumerable) do
    Enum.reduce(enumerable, 0, fn { terrain, index }, trees ->
      charset = String.codepoints(terrain)
      size = Enum.count(charset)
      pinpoint = Enum.at(charset, rem(index * 1, size))

      # IO.inspect("#{ terrain }, char_index: #{ rem(index * 3, size) }, pin: #{ pinpoint }, ")

      cond do
        pinpoint == "#" -> trees + 1
        true -> trees
      end
    end)
  end
end
