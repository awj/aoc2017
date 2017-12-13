defmodule Aoc10 do
  @moduledoc """
  Documentation for Aoc10.
  """

  defstruct state: nil, skip: 0, size: 0, position: 0
 
  def new(size) do
    state = (0..(size-1))
    |> Enum.into(Map.new, fn(x) -> {x,x} end)

    %Aoc10{state: state, size: size}
  end

  def process(size, commands) do
    state = new(size)

    commands
    |> Enum.reduce(state, fn(x, acc) -> resolve(acc, x) end)
  end

  def resolve(content, length) do
    content
    |> reverse(length)
    |> new_position(length)
  end

  def new_position(content, length) do
    span = content.position + length + content.skip
    next = rem(span, content.size)
    %{content | position: next, skip: content.skip + 1}
  end

  def reverse(content, length) do
    updates = indices(content, length)
    |> fn(arr) -> Enum.zip(arr, Enum.reverse(arr)) end.()
    |> Enum.into(Map.new, fn({k,v}) -> {k, Map.get(content.state, v)} end)

    %{content | state: Map.merge(content.state, updates) }
  end

  def indices(content, length) do
    target = content.position + length - 1
    if target < content.size do
      Enum.to_list((content.position)..(target))
    else
      remain = rem(target, content.size)
      Enum.to_list((content.position)..(content.size - 1)) ++ Enum.to_list(0..(remain))
    end
  end
end
