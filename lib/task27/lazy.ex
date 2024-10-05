defmodule Task27.Lazy do
  @moduledoc "5. Ленивое выполнение с использованием Stream"
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

  def quadratic_primes_lazy do
    {a, b, count} =
      Stream.flat_map(-999..999, fn a ->
        Stream.map(-1000..1000, fn b ->
          {a, b, count_primes(a, b)}
        end)
      end)
      |> Enum.max_by(&elem(&1, 2))

    %{product: a * b, a: a, b: b, count: count}
  end
end
