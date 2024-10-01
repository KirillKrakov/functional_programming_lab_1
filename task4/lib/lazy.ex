defmodule Lazy do
  # Проверка, является ли число палиндромом
  def palindrome?(n) do
    str_n = Integer.to_string(n)
    str_n == String.reverse(str_n)
  end
  # 5. Ленивое выполнение с использованием Stream
  def largest_palindrome_lazy() do
    Stream.flat_map(999..100//-1, fn i ->
      Stream.map(999..100//-1, fn j -> i * j end)
    end)
    |> Stream.filter(&palindrome?/1)
    |> Enum.max()
  end
end
