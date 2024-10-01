defmodule Task4 do
  # Проверка, является ли число палиндромом
  def palindrome?(n) do
    str_n = Integer.to_string(n)
    str_n == String.reverse(str_n)
  end

  # 1.1 Хвостовая рекурсия
  def largest_palindrome_tail_recur() do
    largest_palindrome_tail_recur(999, 999, 0)
  end

  defp largest_palindrome_tail_recur(i, _, max_p) when i < 100, do: max_p
  defp largest_palindrome_tail_recur(i, j, max_p) when j < 100, do: largest_palindrome_tail_recur(i - 1, 999, max_p)
  defp largest_palindrome_tail_recur(i, j, max_p) do
    product = i * j
    new_max_p = if palindrome?(product), do: max(product, max_p), else: max_p
    largest_palindrome_tail_recur(i, j - 1, new_max_p)
  end

  # 1.2 Обычная рекурсия
  def largest_palindrome_usual_recur() do
    largest_palindrome_usual_recur(999, 999)
  end

  defp largest_palindrome_usual_recur(i, _) when i < 100, do: 0
  defp largest_palindrome_usual_recur(i, j) when j < 100, do: largest_palindrome_usual_recur(i - 1, 999)
  defp largest_palindrome_usual_recur(i, j) do
    product = i * j
    max_p = if palindrome?(product), do: product, else: 0
    max(max_p, largest_palindrome_usual_recur(i, j - 1))
  end

  # 2. Модульная реализация
  def three_digit_numbers() do
    100..999 |> Enum.to_list()
  end

  def generate_products(numbers) do
    for x <- numbers, y <- numbers, do: x * y
  end

  def filter_palindromes(products) do
    Enum.filter(products, &palindrome?/1)
  end

  def largest_palindrome_modular() do
    three_digit_numbers()
    |> generate_products()
    |> filter_palindromes()
    |> Enum.max()
  end

  # 3. Генерация последовательности при помощи отображения (map)
  def largest_palindrome_map() do
    100..999
    |> Enum.flat_map(fn i ->
      Enum.map(100..999, fn j -> i * j end)
    end)
    |> Enum.filter(&palindrome?/1)
    |> Enum.max()
  end

   # 4. Специальный синтаксис для циклов (использование for и reduce?)
   def largest_palindrome_reduce() do
    for i <- 999..100//-1,
        j <- 999..100//-1,
        product = i * j,
        palindrome?(product) do
      product
    end
    |> Enum.reduce(-1, &max/2)
  end

  # 5. Ленивое выполнение с использованием Stream
  def largest_palindrome_lazy() do
    Stream.flat_map(999..100//-1, fn i ->
      Stream.map(999..100//-1, fn j -> i * j end)
    end)
    |> Stream.filter(&palindrome?/1)
    |> Enum.max()
  end
end
