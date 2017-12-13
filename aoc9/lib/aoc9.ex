defmodule Aoc9 do
  @moduledoc """
  Documentation for Aoc9.
  """

  defstruct points: 0, nesting: 0, in_garbage: false, ignore: false, garbage: 0

  def score(input) do
    input
    |> String.graphemes
    |> Enum.reduce(%Aoc9{}, fn(c, acc) -> parse(c, acc) end)
    |> Map.get(:points)
  end

  def garbage(input) do
    input
    |> String.graphemes
    |> Enum.reduce(%Aoc9{}, fn(c, acc) -> parse(c, acc) end)
    |> Map.get(:garbage)
  end
  
  def parse(_, %Aoc9{ignore: true} = state) do
    %{state | ignore: false}
  end
    
  def parse("!", %Aoc9{in_garbage: true} = state) do
    %{state | ignore: true}
  end
  
  def parse("{", %Aoc9{in_garbage: false} = state) do
    %{state | nesting: state.nesting + 1}
  end

  def parse("}", %Aoc9{in_garbage: false} = state) do
    %{state | nesting: state.nesting - 1, points: state.points + state.nesting}
  end

  def parse("<", %Aoc9{in_garbage: false} = state) do
    %{state | in_garbage: true}
  end

  def parse(">", state) do
    %{state | in_garbage: false}
  end

  def parse(_, %Aoc9{in_garbage: true} = state) do
    %{state | garbage: state.garbage + 1}
  end

  def parse(_, state) do
    state
  end
end
