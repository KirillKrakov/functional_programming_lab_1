defmodule Task4.Lazy do
  @moduledoc "5. Ленивое выполнение с использованием Stream"
  # Проверка, является ли число палиндромом
  defp palindrome?(n) do
    str_n = Integer.to_string(n)
    str_n == String.reverse(str_n)
  end

  def largest_palindrome_lazy do
    Stream.flat_map(999..100//-1, fn i ->
      Stream.map(999..100//-1, fn j -> i * j end)
    end)
    |> Stream.filter(&palindrome?/1)
    |> Enum.max()
  end
end
