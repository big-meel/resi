defmodule ResiTest do
  use ExUnit.Case
  doctest Resi

  test "greets the world" do
    assert Resi.hello() == :world
  end
end
