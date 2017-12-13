defmodule Aoc7 do
  @moduledoc """
  Documentation for Aoc7.
  """
  defstruct name: nil, weight: nil, holding: nil, should_hold: nil

  def new(name, weight, should_hold \\ []) do
    %Aoc7{name: name, weight: weight, holding: [], should_hold: should_hold}
  end

  def organize(entries) do
    initial_map =  Enum.into(entries, Map.new, fn(x) -> {x.name, x} end)
    [first | rest] = entries
    organize first, initial_map
  end

  def organize(root, to_process) when map_size(to_process) == 0 do
    root
  end

  def organize(root, to_process) do
    if satisfied?(root) do
      new_root = elem(Enum.random(to_process), 1)
      new_process_set = Map.put(to_process, root.name, root) |> Map.delete(new_root.name)
      if map_size(new_process_set) == 1 do
        organize(root, %{})
      else
        organize(new_root, new_process_set)
      end
    else
      {chosen, remainder} = Map.split(to_process, root.should_hold)
      {satisfied, unsatisfied} = Map.values(chosen) |> Enum.split_with(fn(x) -> satisfied?(x) end)
      updated_root = %{root | holding: root.holding ++ satisfied}
      new_process_set = Map.merge(Enum.into(unsatisfied, Map.new, fn(x) -> {x.name, x} end), remainder)
      if map_size(new_process_set) == 0 do
        updated_root
      else
        new_root = elem(Enum.random(new_process_set), 1)
        to_process = Map.put(new_process_set, updated_root.name, updated_root) |> Map.delete(new_root.name)
        organize(new_root, to_process)
      end
    end
  end

  def print_tree(node, depth \\ 0) do
    spacing = String.duplicate(" ", depth)
    IO.puts "#{spacing}#{node.name}(#{total_weight(node)})"
    for n <- node.holding do
      print_tree n, depth + 2
    end
  end

  # Add the total_weight of all children to this node's own weight.
  def total_weight(%Aoc7{weight: weight, holding: holding}) do
    Enum.reduce(holding,weight, fn(x, acc) -> acc + total_weight(x) end)
  end

  def leaf?(%Aoc7{should_hold: sh}) do
    length(sh) == 0
  end
  
  def balanced?(%Aoc7{holding: nil}) do
    true
  end

  def balanced?(%Aoc7{holding: []}) do
    true
  end
  
  def balanced?(%Aoc7{holding: holding}) do
    {highest, lowest} = holding
    |> Enum.map(&(total_weight(&1)))
    |> Enum.min_max

    highest == lowest
  end

  def should_hold?(parent, child) do
    Enum.member?(parent.should_hold, child.name)
  end

  def add(elem, %Aoc7{should_hold: should_hold} = root) when length(should_hold) == 0 do
    {:no_match, root}
  end

  def add(elem, %Aoc7{should_hold: should_hold} = root) when length(should_hold) != 0 do
    # If root should hold elem, insert it and be done
    if should_hold?(root, elem) && satisfied?(elem) do
      {:inserted, %{ root | holding: [elem | root.holding] } }
    else
      {:no_match, root}
    end
  end

  def satisfied?(%Aoc7{name: _, weight: _, holding: holding, should_hold: should_hold}) do
    sorted_hold = Enum.sort should_hold
    sorted_keys = Enum.sort Enum.map(holding, &(&1.name))

    sorted_keys == sorted_hold
  end

  def parse(line) do
    [name, weight | holding] = line
    |> String.trim
    |> String.split(" ")
    |> Enum.reject(&(&1 == "->"))
    |> Enum.map(&(String.replace(&1,",", "", trim: true)))

    
    {weight, _} = weight
    |> String.replace("(", "")
    |> String.replace(")", "")
    |> Integer.parse

    Aoc7.new name, weight, holding
  end

  def read(input_string) do
    input_string
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&(Aoc7.parse(&1)))
  end

  def load(input_filename) do
    {:ok, input} = File.read(input_filename)
    input
    |> read
  end

  def combine(a,b) when a == b do
    {:halt, a}
  end

  def combine(a,b) do
    {result, root} = add(a,b)
    case result do
      :inserted -> {:cont, root}
      :no_match -> {:cont, a}
    end
  end
end
