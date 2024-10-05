defmodule Task4.TailRecursion do
  # Проверка, является ли число палиндромом
  defp is_palindrome(n) do
    str_n = Integer.to_string(n)
    str_n == String.reverse(str_n)
  end

  # 1.1 Хвостовая рекурсия
  def largest_palindrome_tail_recur() do
    largest_palindrome_tail_recur(999, 999, 0)
  end

  defp largest_palindrome_tail_recur(i, _, max_p) when i < 100, do: max_p

  defp largest_palindrome_tail_recur(i, j, max_p) when j < 100,
    do: largest_palindrome_tail_recur(i - 1, 999, max_p)

  defp largest_palindrome_tail_recur(i, j, max_p) do
    product = i * j
    new_max_p = if is_palindrome(product), do: max(product, max_p), else: max_p
    largest_palindrome_tail_recur(i, j - 1, new_max_p)
  end
end
