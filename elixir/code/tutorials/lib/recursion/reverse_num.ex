defmodule Tutorials.Recursion.ReverseNum do
  def rev(num, acc\\0)
  def rev(0, acc), do: acc

  def rev(num, acc) do
    new_num = div(num, 10)
    new_acc = acc * 10 + rem(num, 10)
    rev(new_num, new_acc)
  end
end
