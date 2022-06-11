defmodule Advent2020.Day7.Bag do
  defstruct name: nil, children: []

  def new(name, children) do
    %Advent2020.Day7.Bag{ name: name, children: children }
  end
end
