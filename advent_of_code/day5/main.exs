defmodule Main do
  def input do
    File.read!("./input.txt")
    |> String.trim()
    |> String.split("\n")
  end

  def call do
    input()
    |> Stream.map(fn x -> position(x) end)
    |> Stream.map(fn x -> seat_id(x) end)
    |> Enum.max
  end

  def call2 do
    seats = input()
            |> Enum.map(fn x -> position(x) end)

    cartesian_product_row_column() -- seats
  end

  def min_max do
    seat_ids = input()
               |> Stream.map(fn x -> position(x) end)
               |> Enum.map(fn x -> { x, seat_id(x) } end)

    min = Enum.min_by(seat_ids, fn { _, id } -> id end)
    max = Enum.max_by(seat_ids, fn { _, id } -> id end)

    { min, max }
  end

  def cartesian_product_row_column do
    rows = Enum.to_list(4..110)
    columns = Enum.to_list(0..7)

    for row <- rows, col <- columns, do:  {row, col}
  end

  def position(position_string) do
    rows = String.slice(position_string, 0..6)
    columns = String.slice(position_string, 7..-1)

    { row_reduce(rows, { "F", "B" }) |> elem(1), row_reduce(columns, { "L", "R" }) |> elem(1) }
  end

  def row_reduce(row_string, mode) do
    { start_min, start_max } = case mode do
      { "F", "B" } -> { 0, 127 }
      { "L", "R" } -> { 0, 7 }
    end

    row_string
    |> String.graphemes
    |> Enum.reduce(binary_divide(start_min, start_max, mode), fn x, acc ->
      binary_divide(acc[x][:min], acc[x][:max], mode)
    end)
  end

  def binary_divide(min, max, _) when max == min do
    { :done, max }
  end

  def binary_divide(min, max, { front, back }) do
    half = (max + 1 - min) / 2

    %{
      front => %{min: trunc(min), max: trunc(max - half)},
      back => %{min: trunc(max - half + 1), max: trunc(max)}
    }
  end

  def seat_id({ row, column }) do
    row * 8 + column
  end
end
