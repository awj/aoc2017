defmodule Aoc1Test do
  use ExUnit.Case
  doctest Aoc1

  test "example captcha computations" do
    assert Aoc1.compute("1122") == 3
    assert Aoc1.compute("1111") == 4
    assert Aoc1.compute("1234") == 0
    assert Aoc1.compute("91212129") == 9
  end

  test "halfway around computations" do
    assert Aoc1.halfway("1212") == 6
    assert Aoc1.halfway("1221") == 0
    assert Aoc1.halfway("123425") == 4
    assert Aoc1.halfway("123123") == 12
    assert Aoc1.halfway("12131415") == 4
  end
end
