defmodule MyApp do
  # Sum 1~100, 101~200, 201~300...
  def sum(n) do
    Enum.sum((100*n+1)..(100*n+100))
  end

  # Create process
  def process(n) do
    parent = self()
    spawn fn -> send(parent, {:sum, sum(n)}) end
    receive do
      {:sum, pid} ->
        "#{inspect pid}"
    end
  end

  def main do
    for i <- 0..99, do: String.to_integer(process(i))
  end
end

# Enum.sum(MyApp.main)
