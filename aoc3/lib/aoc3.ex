defmodule Aoc3 do
  @moduledoc """
  Documentation for Aoc3.
  """

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
