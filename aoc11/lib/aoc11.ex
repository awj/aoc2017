defmodule Aoc11 do
  @moduledoc """
  Documentation for Aoc11.
  """

  defstruct north: 0, northeast: 0, northwest: 0, south: 0, southeast: 0, southwest: 0

  def count(input) do
    input
    |> String.trim
    |> String.split(",")
    |> Enum.reduce(%Aoc11{}, &(ingest(&2,&1)))
  end

  def count_parsed(input) do
    input 
    |> Enum.reduce(%Aoc11{}, &(ingest(&2,&1)))
  end

  def steps(input) do
    input.north + input.south + input.northeast + input.northwest + input.southeast + input.southwest
  end

  def ingest(current, dir) do
    case dir do
      "n" -> %{current | north: current.north + 1}
      "s" -> %{current | south: current.south + 1}
      "ne" -> %{current | northeast: current.northeast + 1}
      "nw" -> %{current | northwest: current.northwest + 1}
      "se" -> %{current | southeast: current.southeast + 1}
      "sw" -> %{current | southwest: current.southwest + 1}
    end
  end

  def successions(enum) do
    count = Enum.count(enum)
    (1..count)
    |> Stream.map(fn(x) -> Enum.take(enum, x) end)
  end

  def minimal(counts) do
    next = simplify(counts)
    cond do
      next == counts -> counts
      true           -> minimal(next)
    end
  end

  # simplifications when we find opposing directions
  def simplify(%Aoc11{north: north, south: south} = current) when north >= south and south > 0 do
    %{current | north: north - south, south: 0}
  end

  def simplify(%Aoc11{northeast: northeast, southwest: southwest} = current) when northeast >= southwest and southwest > 0 do
    %{current | northeast: northeast - southwest, southwest: 0}
  end

  def simplify(%Aoc11{northwest: northwest, southeast: southeast} = current) when northwest >= southeast and southeast > 0 do
    %{current | northwest: northwest - southeast, southeast: 0}
  end
  
  def simplify(%Aoc11{north: north, south: south} = current) when south >= north and north > 0 do
    %{current | south: south - north, north: 0}
  end

  def simplify(%Aoc11{northwest: northwest, southeast: southeast} = current) when southeast >= northwest and northwest > 0 do
    %{current | southeast: southeast - northwest, northwest: 0}
  end

  def simplify(%Aoc11{northeast: northeast, southwest: southwest} = current) when southwest >= northeast and northeast > 0 do
    %{current | southwest: southwest - northeast, northeast: 0}
  end
    
  # Simplifications of a vertical + opposing diagonal to the vertical direction diagonal (e.g. north + southeast -> northeast)
  def simplify(%Aoc11{north: north, southeast: southeast} = current) when north >= southeast and southeast > 0 do
    diff = north - southeast
    %{current | north: north - diff, southeast: 0, northeast: current.northeast + diff }
  end

  def simplify(%Aoc11{north: north, southeast: southeast} = current) when southeast >= north and north > 0 do
    diff = southeast - north
    %{current | north: 0, southeast: southeast - diff, northeast: current.northeast + diff }
  end

  def simplify(%Aoc11{north: north, southwest: southwest} = current) when north >= southwest and southwest > 0 do
    diff = north - southwest
    %{current | north: north - diff, southwest: 0, northwest: current.northwest + diff }
  end

  def simplify(%Aoc11{north: north, southwest: southwest} = current) when southwest >= north and north > 0 do
    diff = southwest - north
    %{current | north: 0, southwest: southwest - diff, northwest: current.northwest + diff }
  end

  def simplify(%Aoc11{south: south, northeast: northeast} = current) when south >= northeast and northeast > 0 do
    diff = south - northeast
    %{current | south: south - diff, northeast: 0, southeast: current.northeast + diff }
  end

  def simplify(%Aoc11{south: south, northeast: northeast} = current) when northeast >= south and south > 0 do
    diff = northeast - south
    %{current | south: 0, northeast: northeast - diff, southeast: current.southeast + diff }
  end

  def simplify(%Aoc11{south: south, northwest: northwest} = current) when south >= northwest and northwest > 0 do
    diff = south - northwest
    %{current | south: south - diff, southwest: 0, northwest: current.northwest + diff }
  end

  def simplify(%Aoc11{south: south, northwest: northwest} = current) when northwest >= south and south > 0 do
    diff = northwest - south
    %{current | south: 0, northwest: northwest - diff, northeast: current.northeast + diff }
  end
  
  def simplify(%Aoc11{northeast: northeast, northwest: northwest} = current) when northeast >= northwest and northwest > 0 do
    diff = northeast - northwest
    %{current | north: current.north + diff, northeast: diff, northwest: 0}
  end

  def simplify(%Aoc11{northwest: northwest, northeast: northeast} = current) when northwest >= northeast and northeast > 0 do
    diff = northwest - northeast
    %{current | north: current.north + diff, northwest: diff, northeast: 0}
  end

  def simplify(%Aoc11{southeast: southeast, southwest: southwest} = current) when southeast >= southwest and southwest > 0 do
    diff = southeast - southwest
    %{current | south: current.south + diff, southeast: diff, southwest: 0}
  end

  def simplify(%Aoc11{southwest: southwest, southeast: southeast} = current) when southwest >= southeast and southeast > 0 do
    diff = southwest - southeast
    %{current | south: current.south + diff, southwest: diff, southeast: 0}
  end
  
  def simplify(current) do
    current
  end
end
