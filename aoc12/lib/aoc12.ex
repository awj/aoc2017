defmodule Aoc12 do
  @moduledoc """
  Documentation for Aoc12.
  """

  defstruct groups: [], pipes: Map.new

  def new(pipes) do
    %Aoc12{pipes: pipes}
  end

  def eval(state, procid) do
    candidates = [procid | Map.get(state.pipes, procid)]

    {contains, not_contain} = state.groups
    |> Enum.split_with(fn(g) -> Enum.any?(candidates, &(MapSet.member?(g, &1))) end)

    if Enum.empty?(contains) do
      %{state | groups: [MapSet.new(candidates) | not_contain] }
    else
      merged = Enum.reduce(contains, fn(x, acc) -> MapSet.union(x, acc) end)
      merged = Enum.reduce(candidates, merged, fn(x, acc) -> MapSet.put(acc, x) end)
      %{state | groups: [merged | not_contain] }
    end
  end

  def parse(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&(parse_line(&1)))
    |> Enum.into(Map.new)
  end

  def parse_line(input) do
    [process, _ | targets] = input
    |> String.trim
    |> String.split(" ")

    {process, _} = Integer.parse(process)

    targets = targets
    |> Enum.map(&(String.trim(&1, ",")))
    |> Enum.map(fn(x) -> {val, _} = Integer.parse(x); val end)

    {process, targets}
  end
end
