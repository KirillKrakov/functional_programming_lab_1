defmodule Task27.Map27 do
  @moduledoc "3. Генерация последовательности при помощи отображения (map)"
  # Проверка, является ли число простым
  defp prime?(n) when n < 2, do: false

  defp prime?(n) do
    prime_helper(n, 2)
  end

  defp prime_helper(n, i) when i * i > n, do: true

  defp prime_helper(n, i) do
    if rem(n, i) == 0 do
      false
    else
      prime_helper(n, i + 1)
    end
  end

  # Квадратичная функция
  defp quadratic(a, b, n) do
    n * n + a * n + b
  end

  # Подсчет последовательных простых чисел
  defp count_primes(a, b) do
    Stream.iterate(0, &(&1 + 1))
    |> Stream.map(&quadratic(a, b, &1))
    |> Stream.take_while(&prime?/1)
    |> Enum.count()
  end

  def quadratic_primes_map do
    a_range = -999..999
    b_range = -1000..1000

    combinations = for a <- a_range, b <- b_range, do: {a, b}

    combinations
    |> Enum.map(fn {a, b} ->
      %{product: a * b, a: a, b: b, count: count_primes(a, b)}
    end)
    |> Enum.filter(&(&1.count > 0))
    |> Enum.max_by(& &1.count)
  end
end
