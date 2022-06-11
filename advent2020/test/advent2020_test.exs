defmodule Advent2020Test do
  use ExUnit.Case
  doctest Advent2020

  test "greets the world" do
    assert Advent2020.hello() == :world
  end
end

defmodule Advent2020Test.Day7 do
  use ExUnit.Case

  test "Advent2020.Day7.parse_rule" do
    good_input = "light red bags contain 1 bright white bag, 2 muted yellow bags."
    good_input2 = "ligt bags contain 3 bananas"
    bad_input = "bananas potatoes 123345"
    assert Advent2020.Day7.parse_rule(good_input) == { :ok, :light_red }
    assert Advent2020.Day7.parse_rule(good_input2) == { :ok, :ligt }
    assert Advent2020.Day7.parse_rule(bad_input) == { :error, "bad rule" }
  end

  test "Advent2020.Day7.parse_children" do
    good_input = " 1 bright white bag, 2 muted yellow bags."
    good_input2 = " 3 bananas yellow bags."
    bad_input = "bananas potatoes 123345"
    assert Advent2020.Day7.parse_children(good_input) == [:bright_white, :muted_yellow]
    assert Advent2020.Day7.parse_children(good_input2) == [:bananas_yellow]
    assert Advent2020.Day7.parse_children(bad_input) == []
  end
end
