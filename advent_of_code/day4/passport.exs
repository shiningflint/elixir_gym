defmodule Passport do
  def new(info) do
    info
    |> String.split(["\n", " "])
    |> Enum.map(fn x ->
      data = String.split(x, ":")
      %{List.first(data) => List.last(data)}
    end)
    |> Enum.reduce(fn x, acc -> Map.merge(x, acc) end)
  end

  def valid_all?(passport) do
    valid_attributes =
      ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
      |> Enum.map(fn key -> valid_attr?(passport, key) end)
      |> Enum.member?(false) == false

    valid?(passport) and valid_attributes
  end

  def valid?(passport) do
    Map.delete(passport, "cid")
    |> Enum.count() == 7
  end

  def valid_attr?(%{"byr" => year}, "byr") do
    year = String.to_integer(year)
    year >= 1920 and year <= 2002
  end

  def valid_attr?(%{"iyr" => year}, "iyr") do
    year = String.to_integer(year)
    year >= 2010 and year <= 2020
  end

  def valid_attr?(%{"eyr" => year}, "eyr") do
    year = String.to_integer(year)
    year >= 2020 and year <= 2030
  end

  def valid_attr?(%{"hgt" => height}, "hgt") do
    case Regex.run(~r"(\d.+)(cm|in)", height) do
      [_, height, "cm"] ->
        height = String.to_integer(height)
        height >= 150 and height <= 193

      [_, height, "in"] ->
        height = String.to_integer(height)
        height >= 59 and height <= 76

      _ ->
        false
    end
  end

  def valid_attr?(%{"hcl" => color}, "hcl") do
    Regex.run(~r"#[0-9a-fA-F]{6}", color) != nil
  end

  def valid_attr?(%{"ecl" => color}, "ecl") do
    valid_colors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    Enum.member?(valid_colors, color)
  end

  def valid_attr?(%{"pid" => pid}, "pid") do
    pid
    |> String.graphemes()
    |> Enum.count() == 9
  end

  def valid_attr?(_, _), do: false
end
