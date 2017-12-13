defmodule Aoc9Test do
  use ExUnit.Case
  doctest Aoc9

  test "handles point scoring" do
    assert Aoc9.score("{}") == 1
    assert Aoc9.score("{{{}}}") == 6
    assert Aoc9.score("{{},{}}") == 5
    assert Aoc9.score("{{{},{},{{}}}}") == 16
    assert Aoc9.score("{<a>,<a>,<a>,<a>}") == 1
    assert Aoc9.score("{{<ab>},{<ab>},{<ab>},{<ab>}}") == 9
    assert Aoc9.score("{{<!!>},{<!!>},{<!!>},{<!!>}}") == 9
    assert Aoc9.score("{{<a!>},{<a!>},{<a!>},{<ab>}}") == 3
  end
end
