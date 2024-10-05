defmodule Task4.Cycle do
  @moduledoc "4. Специальный синтаксис для циклов (for)"
  # В реальности for отвечает за списковые включения, а не циклы.
  # Фактически в Elixir спец. синтаксиса для циклов нет.
  # Проверка, является ли число палиндромом
  defp palindrome?(n) do
    str_n = Integer.to_string(n)
    str_n == String.reverse(str_n)
  end

  def largest_palindrome_cycle do
    for i <- 999..100//-1,
        j <- 999..100//-1,
        product = i * j,
        palindrome?(product) do
      product
    end
    |> Enum.max()
  end
end
