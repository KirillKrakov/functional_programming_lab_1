defmodule Task27.UsualRecursion do
  # Проверка, является ли число простым
  defp is_prime(n) when n < 2, do: false

  defp is_prime(n) do
    is_prime_helper(n, 2)
  end

  defp is_prime_helper(n, i) when i * i > n, do: true

  defp is_prime_helper(n, i) do
    if rem(n, i) == 0 do
      false
    else
      is_prime_helper(n, i + 1)
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
    |> Stream.take_while(&is_prime/1)
    |> Enum.count()
  end

  # 1.2 Обычная рекурсия
  def quadratic_primes_usual_recur() do
    quadratic_primes_usual_recur(-999, -1000)
  end

  defp quadratic_primes_usual_recur(a, b) do
    cond do
      a > 1000 ->
        %{product: 0, a: 0, b: 0, count: 0}

      b > 1001 ->
        quadratic_primes_usual_recur(a + 1, -1000)

      true ->
        count = count_primes(a, b)
        next_result = quadratic_primes_usual_recur(a, b + 1)

        if count > next_result.count do
          %{product: a * b, a: a, b: b, count: count}
        else
          next_result
        end
    end
  end
end
