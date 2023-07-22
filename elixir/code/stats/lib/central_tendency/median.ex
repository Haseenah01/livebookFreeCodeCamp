defmodule Stats.CentralTendency.Median do
  require Integer
  alias Stats.Errors
  alias Stats.Validators
  def median(num_list) when is_list(num_list) do
    num_list
    |> Validators.validate_num_list()
    |> calc_median()
  end
  def median(_), do: Errors.invalid_data_type()

  #-----------------------------------------------------

  defp calc_median({:error, _msg}), do: Errors.invalid_data_type()
  defp calc_median({false, _}), do: Errors.invalid_data_type()
  defp calc_median({true, num_list}) do
    count = num_list |> Enum.count()
    num_list
    |> Enum.sort()
    |> get_median(Integer.is_even(count), count)
  end

  #------------------------------------------------------

  defp get_median(num_list, false, count), do: Enum.at(num_list, div(count, 2))
  defp get_median(num_list, true, count) do
    a = Enum.at(num_list, div(count - 1, 2))
    b = Enum.at(num_list, div(count, 2))

    (a + b) / 2
  end
end
