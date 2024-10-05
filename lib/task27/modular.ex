defmodule Task27.Modular do
  @moduledoc "2. Модульная реализация (map, filter, reduce)"
  defmodule PrimeChecker do
    @moduledoc "Модуль для проверки, является ли число простым"
    def prime?(n) when n < 2, do: false

    def prime?(n) do
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
  end

  defmodule QuadraticFunction do
    @moduledoc "Модуль с формулой квадратичной функции"
    def quadratic(a, b, n) do
      n * n + a * n + b
    end
  end

  defmodule PrimesCounter do
    @moduledoc "Модуль для подсчета последовательных простых чисел"
    def count_primes(a, b) do
      Stream.iterate(0, &(&1 + 1))
      |> Stream.map(&QuadraticFunction.quadratic(a, b, &1))
      |> Stream.take_while(&PrimeChecker.prime?/1)
      |> Enum.count()
    end
  end

  defmodule CoefficientsGenerator do
    @moduledoc "Модуль для генерации всех комбинаций коэффициентов a и b"
    def coefficients do
      for a <- -999..999, b <- -1000..1000, do: {a, b}
    end
  end

  defmodule ResultsGenerator do
    @moduledoc "Модуль для подсчёта результатов у каждой комбинации a и b"
    def generate_results(combinations) do
      # аналог строки:
      # for {a, b} <- coefficients(), into: [] do
      # %{product: a * b, a: a, b: b, count: PrimesCounter.count_primes(a, b)} end
      Enum.map(combinations, fn {a, b} ->
        %{product: a * b, a: a, b: b, count: PrimesCounter.count_primes(a, b)}
      end)
    end
  end

  defmodule ResultsFilter do
    @moduledoc "Модуль для фильтрации результатов с положительным n"
    def filter_results(results) do
      Enum.filter(results, &(&1.count > 0))
    end
  end

  defmodule MaxResultFinder do
    @moduledoc "Модуль для получения результата с наибольшим n"
    def find_max(results) do
      Enum.max_by(results, & &1.count)
    end
  end

  def quadratic_primes_modular do
    CoefficientsGenerator.coefficients()
    |> ResultsGenerator.generate_results()
    |> ResultsFilter.filter_results()
    |> MaxResultFinder.find_max()
  end
end
