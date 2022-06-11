defmodule Main do
  def comb(0, _), do: [[]]
  def comb(_, []), do: []
  def comb(m, [h|t]) do
    (for l <- comb(m-1, t), do: [h|l]) ++ comb(m, t)
  end

  def call(values) do
    top_map = fn v ->
      first_lists = Enum.map(values, fn vo -> v + vo == 2020 end)
      Enum.any?(first_lists)
    end

    Enum.filter(values, top_map)
  end

  def call3(values) do
    combinations = comb(3, values)
    Enum.filter(combinations, fn c -> Enum.sum(c) == 2020 end)
  end
end
