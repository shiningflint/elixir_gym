defmodule Main do
  def input do
    File.read!("./input.txt")
    |> String.trim()
    |> String.split("\n")
  end

  def call do
    input()
    |> Enum.map(fn s -> Password.new(s) end)
    |> Enum.filter(fn s -> s != nil end)
    |> Enum.map(fn p -> Password.valid?(p) end)
    |> Enum.filter(fn p -> p == true end)
    |> length
  end

  def call_2 do
    input()
    |> Enum.map(fn s -> Password.new(s) end)
    |> Enum.filter(fn s -> s != nil end)
    |> Enum.map(fn p -> Password.valid_part_two?(p) end)
    |> Enum.filter(fn p -> p == true end)
    |> length
  end
end
