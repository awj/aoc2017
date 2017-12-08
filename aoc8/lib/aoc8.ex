defmodule Aoc8 do
  @moduledoc """
  Documentation for Aoc8.
  """

  def parse(instruction) do
    [reg, act, change, _, cond_reg, comp, val] = instruction
    |> String.trim
    |> String.split(" ")

    {change, _} = Integer.parse(change)
    {val, _} = Integer.parse(val)

    case act do
      "inc" -> {reg, change, cond_reg, comp, val}
      "dec" -> {reg, -change, cond_reg, comp, val}
    end
  end

  def find_highest_value(input) do
    state = {0, Map.new}
    
    {highest, _} = input
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&(parse(&1)))
    |> Enum.reduce(state, fn(inst, state) -> execute(inst, state) end)

    highest
  end

  def execute({reg, change, cond_reg, comp, val}, {highest, state}) do
    if runnable?(state, cond_reg, comp, val) do
      current = Map.get(state, reg, 0)
      updated = current + change
      new_state = Map.put(state, reg, updated)

      if updated > highest do
        {updated, new_state}
      else
        {highest, new_state}
      end
    else
      {highest, state}
    end
  end

  def runnable?(state, cond_reg, comp, val) do
    current = Map.get(state, cond_reg, 0)

    case comp do
      ">"  -> current > val
      ">=" -> current >= val
      "<"  -> current < val
      "<=" -> current <= val
      "==" -> current == val
      "!=" -> current != val
    end
  end
end
