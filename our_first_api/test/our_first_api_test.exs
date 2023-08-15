defmodule OurFirstApiTest do
  use ExUnit.Case
  doctest OurFirstApi

  test "greets the world" do
    assert OurFirstApi.hello() == :world
  end
end
