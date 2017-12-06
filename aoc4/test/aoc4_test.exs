defmodule Aoc4Test do
  use ExUnit.Case
  doctest Aoc4

  test "passphrase validation" do
    assert Aoc4.valid?("aa bb cc dd ee") == true
    assert Aoc4.valid?("aa bb cc dd aa") == false
    assert Aoc4.valid?("aa bb cc dd aaa") == true
  end
end
