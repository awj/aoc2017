defmodule Aoc5 do
  @moduledoc """
  Documentation for Aoc5.
  """
  def steps(input) do
    run_steps({0, input, 0})
  end

  def run_steps({loc, list, count}) do
    if loc >= Enum.count(list) do
      count
    else
      jmp = Enum.at(list, loc)
      new_list = List.replace_at(list, loc, jmp + 1)
      run_steps {loc + jmp, new_list, count + 1}
    end
  end

  def wacky_steps(input) do
    run_wacky_steps({0, input, Enum.count(input), 0})
  end

  def run_wacky_steps({loc, list, len, count}) do
    if loc >= len || loc < 0 do
      count
    else
      jmp = Enum.at(list, loc)
      new_jmp = if jmp >= 3, do: jmp - 1, else: jmp + 1
      new_list = List.replace_at(list, loc, new_jmp)
      run_wacky_steps {loc + jmp, new_list, len, count + 1}
    end
  end
end
