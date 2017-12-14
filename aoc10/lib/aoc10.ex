defmodule Aoc10 do
  @moduledoc """
  Documentation for Aoc10.
  """

  use Bitwise

  defstruct state: nil, skip: 0, size: 0, position: 0
 
  def new(size) do
    state = (0..(size-1))
    |> Enum.into(Map.new, fn(x) -> {x,x} end)

    %Aoc10{state: state, size: size}
  end

  def process_rounds(size, commands, rounds) do
    state = new(size)

    run_rounds(state, commands, rounds)
  end

  def run_rounds(state, _, 0) do
    state
  end

  def run_rounds(state, commands, rounds) do
    new_state = commands
    |> Enum.reduce(state, fn(x, acc) -> resolve(acc, x) end)

    run_rounds(new_state, commands, rounds - 1)
  end

  # Note: assume 256 size state
  def xor_blocks(state) do
    (0..15)
    |> Enum.map(fn(x) -> get_block(x, state) end)
  end

  def print_block(block) do
    block
    |> Enum.map(fn(x) -> stringify(x) end)
    |> Enum.join("")
  end

  def stringify(digit) do
    s = Integer.to_string(digit, 16)
    if String.length(s) == 1 do
      "0#{s}"
    else
      s
    end
  end

  def get_block(id, state) do
    start = id * 16
    ending = start + 15
    (start..ending)
    |> Enum.map(fn(x) -> Map.get(state, x) end)
    |> Enum.reduce(fn(x, acc) -> x ^^^ acc end)
  end

  def process(size, commands) do
    state = new(size)

    commands
    |> Enum.reduce(state, fn(x, acc) -> resolve(acc, x) end)
  end

  def read_commands(input) do
    Enum.to_list(to_charlist(input)) ++ [17, 31, 73, 47, 23]
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
