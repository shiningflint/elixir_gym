defmodule Password do
  defstruct [
    min: nil,
    max: nil,
    character: "",
    value: "",
  ]

  def new(input) do
    case Regex.run(~r/^(\d+)-(\d+) (.): (.+)$/, input) do
      nil -> nil
      list ->
        %Password{
          min: Enum.at(list, 1) |> String.to_integer,
          max: Enum.at(list, 2) |> String.to_integer,
          character: Enum.at(list, 3),
          value: Enum.at(list, 4),
        }
    end
  end

  def valid?(password) do
    char_length = password.value
                  |> String.codepoints
                  |> Enum.filter(fn c -> c == password.character end)
                  |> length

    if char_length in password.min..password.max, do: true, else: false
  end

  def valid_part_two?(password) do
    min_valid = fn ->
      c = password.value
          |> String.codepoints
          |> Enum.at(password.min - 1)
      if c == password.character, do: true, else: false
    end

    max_valid = fn ->
      c = password.value
          |> String.codepoints
          |> Enum.at(password.max - 1)
      if c == password.character, do: true, else: false
    end

    case { min_valid.(), max_valid.() } do
      { true, true } -> false
      { false, false } -> false
      { true, false } -> true
      { false, true } -> true
    end
  end
end
