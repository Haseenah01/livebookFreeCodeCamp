defmodule Stats do
  alias Stats.CentralTendency.{Mean, Median, Mode}

  # def population_mean(nums), do: Mean.population_mean(nums)
  @spec population_mean([number]) :: float | {:error, <<_::136>>}
  defdelegate population_mean(nums), to: Mean #does the same thing as above function

  @spec sample_mean([number]) :: float | {:error, <<_::136>>}
  defdelegate sample_mean(nums), to: Mean

  @spec median(any) :: any
  defdelegate median(num_list), to: Median

  @spec mode(maybe_improper_list) :: nil | list
  defdelegate mode(num_list), to: Mode
end
