defmodule Aoc1Test do
  use ExUnit.Case
  doctest Aoc1

  test "example captcha computations" do
    assert Aoc1.compute("1122") == 3
    assert Aoc1.compute("1111") == 4
    assert Aoc1.compute("1234") == 0
    assert Aoc1.compute("91212129") == 9
  end
end
