defmodule AsyncProcess do
  def main_sync do
    Enum.each(1..3, fn index -> IO.puts(run_query("#{index} sync bananas")) end)
  end

  def main_async do
    1..3
    |> Enum.map(&async_query("#{&1} asenc babanas"))
    |> Enum.map(fn _ -> get_result() end)
  end

  def test_async do
    async_query("test babanas")
    async_query("test potatoes")

    get_result()
    get_result()
  end

  def async_query(query_def) do
    IO.puts("Run async query #{query_def}")
    caller = self()

    spawn(fn ->
      send(
        caller,
        {:query_result, run_query(query_def)}
      )

      # IO.puts(run_query(query_def))
    end)
  end

  def get_result do
    receive do
      {:query_result, result} -> result
    end
  end

  def run_query(query_def) do
    Process.sleep(2000)
    "#{query_def} result"
  end
end
