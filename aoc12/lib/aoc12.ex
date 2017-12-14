defmodule Aoc12 do
  @moduledoc """
  Documentation for Aoc12.
  """

  defstruct seen: MapSet.new, can_reach: MapSet.new, pipes: Map.new

  def new(pipes) do
    %Aoc12{pipes: pipes}
  end

  def eval(state, procid) do
    state = %{state | seen: MapSet.put(state.seen, procid), can_reach: MapSet.put(state.can_reach, procid) }
    worklist = Map.get(state.pipes, procid)
    |> Enum.reject(fn(x) -> MapSet.member?(state.seen, x) end)

    Enum.reduce(worklist, state, fn(x, acc) -> eval(acc, x) end)
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
