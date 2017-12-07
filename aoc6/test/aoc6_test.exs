defmodule Aoc6Test do
  use ExUnit.Case

  test "bank reallocation" do
    banks = Aoc6.Banks.new([0,2,7,0])
    bank2 = Aoc6.Banks.reallocate(banks)
    assert bank2.current == [2,4,1,2]
    bank3 = Aoc6.Banks.reallocate bank2
    assert bank3.current == [3,1,2,3]
    bank4 = Aoc6.Banks.reallocate bank3
    assert bank4.current == [0,2,3,4]
    bank5 = Aoc6.Banks.reallocate bank4
    assert bank5.current == [1,3,4,1]
    bank6 = Aoc6.Banks.reallocate bank5
    assert bank6.current == [2,4,1,2]
    assert Aoc6.Banks.seen?(bank6)
  end
end
