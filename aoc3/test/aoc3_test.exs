defmodule Aoc3Test do
  use ExUnit.Case
  doctest Aoc3

  test "greets the world" do
    assert Aoc3.steps(1) == 0
    assert Aoc3.steps(12) == 3
    assert Aoc3.steps(23) == 2
    assert Aoc3.steps(1024) == 31
  end
end
