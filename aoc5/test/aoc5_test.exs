defmodule Aoc5Test do
  use ExUnit.Case

  test "jumping fool" do
    assert Aoc5.steps([0, 3, 0, 1, -3]) == 5
  end

  test "jumping bigger fool" do
    assert Aoc5.wacky_steps([0, 3, 0, 1, -3]) == 10
  end
end
