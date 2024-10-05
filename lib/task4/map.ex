defmodule Task4.Map4 do
  @moduledoc "3. Генерация последовательности при помощи отображения (map)"
  # Проверка, является ли число палиндромом
  defp palindrome?(n) do
    str_n = Integer.to_string(n)
    str_n == String.reverse(str_n)
  end

  def largest_palindrome_map do
    100..999
    |> Enum.flat_map(fn i ->
      Enum.map(100..999, fn j -> i * j end)
    end)
    |> Enum.filter(&palindrome?/1)
    |> Enum.max()
  end
end
