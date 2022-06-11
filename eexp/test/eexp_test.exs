defmodule EexpTest do
  use ExUnit.Case
  doctest Eexp

  test "greets the world" do
    assert Eexp.hello() == :world
  end
end
