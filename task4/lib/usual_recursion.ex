defmodule UsualRecursion do

  # Проверка, является ли число палиндромом
  def palindrome?(n) do
    str_n = Integer.to_string(n)
    str_n == String.reverse(str_n)
  end

  # 1.2 Обычная рекурсия
  def largest_palindrome_usual_recur() do
    largest_palindrome_usual_recur(999, 999)
  end

  defp largest_palindrome_usual_recur(i, _) when i < 100, do: 0
  defp largest_palindrome_usual_recur(i, j) when j < 100, do: largest_palindrome_usual_recur(i - 1, 999)
  defp largest_palindrome_usual_recur(i, j) do
    product = i * j
    max_p = if palindrome?(product), do: product, else: 0
    max(max_p, largest_palindrome_usual_recur(i, j - 1))
  end
end
