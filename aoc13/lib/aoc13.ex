defmodule Aoc13 do
  @moduledoc """
  Documentation for Aoc13.
  """
  defmodule Scanner do
    defstruct depth: 0, range: 0

    def new(depth, range) do
      %Scanner{depth: depth, range: range}
    end

    def severity(%Scanner{range: range, depth: depth}) do
      range * depth
    end

    def any_hits?(time, scanners) do
      Enum.any?(scanners, fn(s) -> will_hit?(s, time) end)
    end

    def will_hit?(%Scanner{range: range, depth: depth}, delay \\ 0) do
      time = delay + depth
      # Scale time back one picosecond to match the offsets for depths
      # (i.e. first scanner is at depth 0, but would be tested at time
      # 1
      if time == 0 do
        true
      else
        zero_every = 2 * (range - 1)

        rem(time, zero_every) == 0
      end
    end
  end

  def parse(line) do
    [depth, range] = line
    |> String.trim
    |> String.split(": ")

    {depth, _} = Integer.parse(depth)
    {range, _} = Integer.parse(range)
    Scanner.new(depth, range)
  end

end
