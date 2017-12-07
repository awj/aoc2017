defmodule Aoc6 do
  @moduledoc """
  Documentation for Aoc6.
  """
  defmodule Banks do
    defstruct current: nil, seen: nil, size: nil

    def new(init) do
      %Banks{current: init, seen: MapSet.new, size: Enum.count(init)}
    end

    def serialize(banks) do
      Enum.join(banks.current, ",")
    end

    def seen?(banks) do
      MapSet.member?(banks.seen, serialize(banks))
    end

    def reallocate(banks) do
      outgoing = serialize(banks)
      new_banks = compute_reallocation(banks.current, banks.size)
      %Banks{current: new_banks, seen: MapSet.put(banks.seen, outgoing), size: banks.size}
    end

    defp compute_reallocation(banklist, size) do
      target = Enum.max(banklist)
      index  = Enum.find_index(banklist, &(&1 ==target))
      zeroed = List.update_at(banklist, index, fn(_) -> 0 end)
      perform_reallocation(zeroed, target, index + 1, size)
    end

    defp perform_reallocation(banklist, 0, _, _) do
      banklist
    end

    defp perform_reallocation(l, target, index, size) when index >= size do
      perform_reallocation(l, target, 0, size)
    end
    
    defp perform_reallocation(banklist, target, index, size) do
      new_list = List.update_at(banklist, index, fn(x) -> x + 1 end)
      new_index  = index + 1
      perform_reallocation(new_list, target - 1, new_index, size)
    end
  end

  def redistributions(banks) do
    skipped = Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while(Banks.new(banks), &(skip(&1,&2)))

    skipped = Banks.new(skipped.current)
    
    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while(skipped, &(process(&1,&2)))
  end

  def skip(_, banks) do
    case Banks.seen?(banks) do
      true -> {:halt, banks}
      false -> {:cont, Banks.reallocate(banks)}
    end
  end

  def process(i, banks) do
    case Banks.seen?(banks) do
      true -> {:halt, i - 1}
      false -> {:cont, Banks.reallocate(banks)}
    end
  end
end
