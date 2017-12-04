defmodule Aoc1 do
  @moduledoc """
  Documentation for Aoc1.
  """

  def compute(input) do
    input
    |> break
    |> total
  end

  def halfway(input) do
    input
    |> break
    |> build_offsets
    |> Enum.filter(&(elem(&1,0) == elem(&1,1)))
    |> Enum.map(&(elem(&1,0)))
    |> Enum.sum
  end
 
  defp build_offsets(input) do
    shiftable = input ++ input ++ input
    len = Kernel.length(input)
    offset = Enum.drop(shiftable, round(len / 2))

    Enum.zip(shiftable, offset) |> Enum.take(len)
  end

  defp break(input_string) do
    input_string
    |> Integer.parse
    |> Kernel.elem(0)
    |> Integer.digits
  end

  defp total(input) do
    last  = List.last input

    input
    |> Enum.reduce([last, []], &(accum(&1, &2)))
    |> Enum.at(1)
    |> Enum.sum
  end

  def accum(num, [acc, rest]) when num == acc do
    [acc, [(num | rest)]]
  end

  def accum(num, [acc, rest]) when num != acc do
    [num, rest]
  end
end
