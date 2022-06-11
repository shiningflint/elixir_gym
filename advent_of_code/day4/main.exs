defmodule Main do
  def input do
    File.read!("./input.txt")
    |> String.trim()
  end

  def call do
    input()
    |> String.split("\n\n")
    |> Enum.map(fn info -> Passport.new(info) end)
    |> Enum.filter(fn passport -> Passport.valid?(passport) end)
    |> Enum.count()
  end

  def call2 do
    input()
    |> String.split("\n\n")
    |> Enum.map(fn info -> Passport.new(info) end)
    |> Enum.filter(fn passport -> Passport.valid_all?(passport) end)
    |> Enum.count()
  end
end
