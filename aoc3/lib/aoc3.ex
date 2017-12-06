defmodule Aoc3 do
  @moduledoc """
  Documentation for Aoc3.
  """

  # Generate an infinite stream of position values based on walking
  # out from the starting point to calculate them.
  def posvalues do
    Stream.resource(
      fn -> {{0,0,:east}, %{ {0,0} => 1 }} end,
      fn({last_move, map}) ->
        {x,y,dir} = move(last_move)
        new_location = {x,y}
        new_value    = calc_value(new_location, map)
        updated_map  = Map.merge(map, %{new_location => new_value})
        { [new_value], { {x,y,dir}, updated_map } }
      end,
      fn(x) -> x end
    )
  end

  # Find the first spiral value that exceeds the provided value, given
  # diagonal calculation
  def diagonal_val(seeking) do
    Aoc3.posvalues
    |> Enum.find(&(&1 > seeking))
  end

  # Look up the value for the position, given the current state map
  def calc_value(pos, map) do
    surrounding(pos)
    |> Stream.map(&(Map.get(map, &1, 0)))
    |> Enum.sum
  end

  # Calculate out the point locations surrounding the provided
  # position
  def surrounding({x,y}) do
    [
      {x - 1, y},
      {x + 1, y},
      {x, y - 1},
      {x, y + 1},
      {x - 1, y - 1},
      {x + 1, y - 1},
      {x - 1, y + 1},
      {x + 1, y + 1},
    ]
  end

  def steps(1) do 0 end
  
  def steps(location) do
    position = {0,0, :east}
    (2..(location))
    |> Enum.reduce(position, fn(_,pos) -> move(pos) end)
    |> calc_distance
  end

  def calc_distance({x,y,_}) do
    abs(x) + abs(y)
  end
  
  def move({0,0,_}) do
    {1,0,:north}
  end

  # Top right turn
  def move({x,y,_}) when
  x > 0 and x == y do
    {x-1, y, :west}
  end

  # bottom right turn
  def move({x,y, _}) when
  x > 0 and y < 0 and (x-1) == (-y) do
    {x, y+1, :north}
  end

  # Top left turn
  def move({x,y, _}) when
  x < 0 and y > 0 and (-x) == y do
    {x, y-1, :south}
  end

  # Bottom left turn
  def move({x,y, _}) when
  x < 0 and y < 0 and x == y do
    {x+1, y, :east}
  end

  def move({x,y,dir}) do
    case dir do
      :north -> {x, y+1, :north}
      :south -> {x, y-1, :south}
      :east  -> {x+1, y, :east}
      :west  -> {x-1, y, :west}
    end
  end

  # def move({x,y}) when
  # x > 0 do
  #   cond do
  #     x == y -> {x-1, y}
  #     x > y  -> {x, y + 1}
  #     x < y  -> {x-1, y}
  #   end
  # end

  # def move({x,y}) when
  # x == 0 do
  #   cond do
  #     y > 0 -> {x-1, y}
  #     y < 0 -> {x+1, y}
  #   end
  # end

  # def move({x,y}) when
  # x < 0 do
  #   cond do
  #     y > 0 && -x < y -> {x-1, y}
  #     y > 0 && -x == y -> {x, y-1}
  #     x == y ->  {x+1, y}
  #   end
  # end
end
