defmodule Lazy do
  # Проверка, является ли число простым
  def is_prime(n) when n < 2, do: false
  def is_prime(n) do
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
  def quadratic(a, b, n) do
    n * n + a * n + b
  end

  # Подсчет последовательных простых чисел
  def count_primes(a, b) do
    Stream.iterate(0, &(&1 + 1))
    |> Stream.map(&quadratic(a, b, &1))
    |> Stream.take_while(&is_prime/1)
    |> Enum.count()
  end
  # 5. Ленивые коллекции (использование Stream)
  def quadratic_primes_lazy() do
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
