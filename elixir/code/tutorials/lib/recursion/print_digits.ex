defmodule Tutorials.Recursion.PrintDigits do
  # Base Case
  def upto(0), do: 0

  # recursive case
  def upto(nums) do
    # 3 , 2 , 1 ,
    IO.puts(nums)
    upto(nums - 1)
  end

end
