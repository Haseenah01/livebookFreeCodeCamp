defmodule SupportSystemTest do
  use ExUnit.Case
  doctest SupportSystem

  test "greets the world" do
    assert SupportSystem.hello() == :world
  end
end
