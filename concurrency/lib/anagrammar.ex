defmodule Anagrammar do
  @dictionary "/usr/share/dict/american-english"

  def build_list(accumulator_pid) do
    words()
    |> Enum.each(&(add_anagram(accumulator_pid, &1)))
  end

  def get_list(accumulator_pid) do
    send(accumulator_pid, {self(), :list})

    receive do
      {:ok, list} ->
        list
        |> Enum.each(&IO.inspect/1)
    end
  end

  defp words do
    File.read!("/usr/share/dict/american-english")
    |> String.split("\n")
  end

  defp add_anagram(accumulator_pid, word) do
    spawn(fn -> _add_anagram(accumulator_pid, word) end)
  end

  defp _add_anagram(accumulator_pid, word) do
    send(accumulator_pid, {self(), {:add, parse(word)}})

    receive do
      :ok -> :ok
    end
  end

  defp parse(word) do
    letters =
      word
      |> String.downcase()
      |> String.split("")
      |> Enum.sort(&(&1 <= &2))
      |> Enum.join()

    {letters, word}
  end
end
