defmodule Task4.Modular do
  @moduledoc "2. Модульная реализация (map, filter, reduce)"
  defmodule PalindromeChecker do
    @moduledoc "Модуль для проверки, является ли число палиндромом"
    def palindrome?(n) do
      str_n = Integer.to_string(n)
      str_n == String.reverse(str_n)
    end
  end

  defmodule ProductGenerator do
    @moduledoc "Модуль для генерации произведений 2 чисел"
    def generate_products do
      100..999
      |> Enum.flat_map(fn i ->
        Enum.map(100..999, fn j -> i * j end)
      end)
    end
  end

  defmodule PalindromeFilter do
    @moduledoc "Модуль для проверки на палиндром"
    def filter_palindromes(products) do
      Enum.filter(products, &PalindromeChecker.palindrome?/1)
    end
  end

  defmodule MaxPalindromeFinder do
    @moduledoc "Модуль для нахождения максимального значения"
    def find_max(products) do
      Enum.reduce(products, -1, &max/2)
    end
  end

  def largest_palindrome_modular do
    ProductGenerator.generate_products()
    |> PalindromeFilter.filter_palindromes()
    |> MaxPalindromeFinder.find_max()
  end
end
