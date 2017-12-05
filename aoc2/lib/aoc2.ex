defmodule Aoc2 do
  @moduledoc """
  Documentation for Aoc2.
  """

  def checksum(input) do
    input
    |> parse
    |> Enum.map(&(row_calc(&1)))
    |> Enum.sum
  end

  def divisible_checksum(input) do
    input
    |> parse
    |> Enum.map(&(divisible_row_calc(&1)))
    |> Enum.sum
  end

  def parse(input_string) do
    String.trim(input_string)
    |> String.split("\n")
    |> Enum.map(&(parse_row(&1)))
  end

  def permutations(row) do
    for x <- row, y <- row -- [x], do: {x, y}
  end

  def row_calc(row) do
    seed = Enum.at(row, 0)
    init = {seed, seed}
    {high, low} = row |> Enum.reduce(init, fn(x, acc) -> absorb(x, acc) end)
    
    high - low
  end

  def divisible_row_calc(row) do
    {high, low} = row
                  |> permutations
                  |> Enum.find(fn({a,b}) -> rem(a, b) == 0 end)
    div(high, low)
  end
  
  def absorb(x, {high, low}) when x > high do
    {x, low}
  end

  def absorb(x, {high, low}) when x < low do
    {high, x}
  end

  def absorb(_, acc) do
    acc
  end
  
  def parse_row(row_string) do
    String.split(row_string, "\t")
    |> Enum.map(&(Integer.parse(&1)))
    |> Enum.map(&(elem(&1,0)))
  end
end
