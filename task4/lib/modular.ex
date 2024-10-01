defmodule Modular do

  # Модуль для проверки, является ли число палиндромом
  defmodule PalindromeChecker do
    def palindrome?(n) do
      str_n = Integer.to_string(n)
      str_n == String.reverse(str_n)
    end
  end
  #Модуль для генерации произведений 2 чисел
  defmodule ProductGenerator do
    def generate_products() do
      100..999
      |> Enum.flat_map(fn i ->
        Enum.map(100..999, fn j -> i * j end)
      end)
    end
  end
  #Модуль для проверки на палиндром
  defmodule PalindromeFilter do
    def filter_palindromes(products) do
      Enum.filter(products, &PalindromeChecker.palindrome?/1)
    end
  end
  #Модуль для нахождения максимального значения
  defmodule MaxPalindromeFinder do
    def find_max(products) do
      Enum.reduce(products,-1, &max/2)
    end
  end
  # 2. Модульная реализация (map, filter, reduce)
  def largest_palindrome_modular() do
    ProductGenerator.generate_products()
    |> PalindromeFilter.filter_palindromes()
    |> MaxPalindromeFinder.find_max()
  end
end
