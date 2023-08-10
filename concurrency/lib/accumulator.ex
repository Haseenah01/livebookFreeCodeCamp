defmodule Accumulator do
  def loop(anagrams \\ %{}) do
    receive do
      {from, {:add, {letters, word}}} ->
        anagrams = add_word(anagrams, letters, word)
        send(from, :ok)
        loop(anagrams) # must put loop/0 inside each match

      {from, :list} ->
        send(from, {:ok, list_anagrams(anagrams)})
        loop(anagrams)
    end
  end

  defp add_word(anagrams, letters, word) do
    words = Map.get(anagrams, letters, [])

    anagrams
    |> Map.put(letters, [word|words])
  end

  defp list_anagrams(anagrams) do
    anagrams
    |> Enum.filter(fn {_k, v} -> length(v) >= 3 end)
  end
end
