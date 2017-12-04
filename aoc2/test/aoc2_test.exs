defmodule Aoc2Test do
  use ExUnit.Case

  test "greets the world" do
    input = """
5 1 9 5
7 5 3
2 4 6 8
"""
    assert Aoc2.checksum(input) == 18
  end
end
