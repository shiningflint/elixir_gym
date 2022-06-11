defmodule Main do
  def input do
    File.read!("./input_small.txt")
    |> String.trim()
    |> String.split("\n")
  end

  def call do
    :bananas
  end

  def parse_rule(line) do
    [parent | child] = String.split(line, " bags contain")

    case Enum.count(child) > 0 do
      true ->
        { :ok, String.split(parent, " ") |> Enum.join("_") |> String.to_existing_atom }
      _ ->
        { :error, "bad rule" }
    end
  end
end

ExUnit.start

defmodule TestMain do
  use ExUnit.Case

  test "Main.parse_rule" do
    good_input = "light red bags contain 1 bright white bag, 2 muted yellow bags."
    good_input2 = "ligt bags contain 3 bananas"
    bad_input = "bananas potatoes 123345"
    assert Main.parse_rule(good_input) == { :ok, :light_red }
    assert Main.parse_rule(good_input2) == { :ok, :ligt }
    assert Main.parse_rule(bad_input) == { :error, "bad rule" }
  end
end
