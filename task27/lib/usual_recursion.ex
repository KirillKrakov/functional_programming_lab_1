defmodule UsualRecursion do
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
    quadratic_primes_usual_recur(-999, 1000, -1000, 1001)
  end

  defp quadratic_primes_usual_recur(a_lower, a_upper, b_lower, b_upper) do
    quadratic_primes_usual_recur(a_upper, b_upper, a_lower, b_lower, 0, {0, 0})
  end

  defp quadratic_primes_usual_recur(a_upper, b_upper, a, b, max_count, max_coeffs) do
    cond do
      a > a_upper ->
        %{product: elem(max_coeffs, 0) * elem(max_coeffs, 1), a: elem(max_coeffs, 0), b: elem(max_coeffs, 1), count: max_count}

      b > b_upper ->
        result = quadratic_primes_usual_recur(a_upper, b_upper, a + 1, -1000, max_count, max_coeffs)
        result

      true ->
        count = count_primes(a, b)
        new_max_count = if count > max_count, do: count, else: max_count
        new_max_coeffs = if count > max_count, do: {a, b}, else: max_coeffs

        quadratic_primes_usual_recur(a_upper, b_upper, a, b + 1, new_max_count, new_max_coeffs)
    end
  end
end
