defmodule Example.Example do
  #Processes
  def add(a, b) do
    IO.puts(a + b)
  end

  def listen do
    receive do
      {:ok, "hello"} -> IO.puts("World")
    end

    listen()
  end
end
