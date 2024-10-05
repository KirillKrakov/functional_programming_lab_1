defmodule Task27.Modular do
  # Модуль для проверки, является ли число простым
  defmodule PrimeChecker do
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
  end

  # Модуль с формулой квадратичной функции
  defmodule QuadraticFunction do
    def quadratic(a, b, n) do
      n * n + a * n + b
    end
  end

  # Модуль для подсчета последовательных простых чисел
  defmodule PrimesCounter do
    def count_primes(a, b) do
      Stream.iterate(0, &(&1 + 1))
      |> Stream.map(&QuadraticFunction.quadratic(a, b, &1))
      |> Stream.take_while(&PrimeChecker.is_prime/1)
      |> Enum.count()
    end
  end

  # Модуль для генерации всех комбинаций коэффициентов a и b
  defmodule CoefficientsGenerator do
    def coefficients() do
      for a <- -999..999, b <- -1000..1000, do: {a, b}
    end
  end

  # Модуль для подсчёта результатов у каждой комбинации a и b
  defmodule ResultsGenerator do
    def generate_results(combinations) do
      # аналог строки for {a, b} <- coefficients(), into: [] do %{product: a * b, a: a, b: b, count: PrimesCounter.count_primes(a, b)} end
      Enum.map(combinations, fn {a, b} ->
        %{product: a * b, a: a, b: b, count: PrimesCounter.count_primes(a, b)}
      end)
    end
  end

  # Модуль для фильтрации результатов с положительным n
  defmodule ResultsFilter do
    def filter_results(results) do
      Enum.filter(results, &(&1.count > 0))
    end
  end

  # Модуль для получения результата с наибольшим n
  defmodule MaxResultFinder do
    def find_max(results) do
      # Аналог строки Enum.max_by(results, & &1.count)
      Enum.reduce(results, nil, fn item, acc ->
        case acc do
          nil -> item
          _ -> if item.count > acc.count, do: item, else: acc
        end
      end)
    end
  end

  # 2. Модульная реализация (map, filter, reduce)
  def quadratic_primes_modular() do
    CoefficientsGenerator.coefficients()
    |> ResultsGenerator.generate_results()
    |> ResultsFilter.filter_results()
    |> MaxResultFinder.find_max()
  end
end
