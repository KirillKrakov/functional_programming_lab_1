# Лабораторная работа по функциональному программированию №1
## Проект Эйлера №3, №28

---

  * Студент: `Краков Кирилл Константинович`
  * Группа: `P3331`
  * ИСУ: `368373`
  * Функциональный язык: `Elixir`

---

## Проблема №3

  * **Название**: `Largest Palindrome Product`
  * **Описание**: A palindromic number reads the same both ways. The largest palindrome made from the product of two $2$-digit numbers is $9009 = 91 \times 99$.
  * **Задание**: Find the largest palindrome made from the product of two $3$-digit numbers.

---

### Основная идея решения

Будем решать задачу простым перебором. Последовательно перемножая числа от 999 до 100 друг с другом (от наибольших к наименьшим), будем проверять получившееся произведение на палиндром. Если получили палиндром, то сравниваем его с текущим максимальным значением и находим из них наибольший. В итоге находим наибольший палиндром, полученный перемножением 2 трёхзначных чисел.

---

### Решение через хвостовую рекурсию

```elixir
defmodule Task4.TailRecursion do
  @moduledoc "1.1 Хвостовая рекурсия"
  # Проверка, является ли число палиндромом
  defp palindrome?(n) do
    str_n = Integer.to_string(n)
    str_n == String.reverse(str_n)
  end

  def largest_palindrome_tail_recur do
    largest_palindrome_tail_recur(999, 999, 0)
  end

  defp largest_palindrome_tail_recur(i, _, max_p) when i < 100, do: max_p

  defp largest_palindrome_tail_recur(i, j, max_p) when j < 100,
    do: largest_palindrome_tail_recur(i - 1, 999, max_p)

  defp largest_palindrome_tail_recur(i, j, max_p) do
    product = i * j
    new_max_p = if palindrome?(product), do: max(product, max_p), else: max_p
    largest_palindrome_tail_recur(i, j - 1, new_max_p)
  end
end
```

### Решение через обычную рекурсию 

```elixir
defmodule Task4.UsualRecursion do
  @moduledoc "1.2 Обычная рекурсия"
  # Проверка, является ли число палиндромом
  defp palindrome?(n) do
    str_n = Integer.to_string(n)
    str_n == String.reverse(str_n)
  end

  def largest_palindrome_usual_recur do
    largest_palindrome_usual_recur(999, 999)
  end

  defp largest_palindrome_usual_recur(i, _) when i < 100, do: 0

  defp largest_palindrome_usual_recur(i, j) when j < 100,
    do: largest_palindrome_usual_recur(i - 1, 999)

  defp largest_palindrome_usual_recur(i, j) do
    product = i * j
    max_p = if palindrome?(product), do: product, else: 0
    max(max_p, largest_palindrome_usual_recur(i, j - 1))
  end
end
```

### Решение через модульность (reduce, filter, map)

```elixir
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
```

### Решение через генерацию последовательности при помощи отображения (map)

```elixir
defmodule Task4.Map4 do
  @moduledoc "3. Генерация последовательности при помощи отображения (map)"
  # Проверка, является ли число палиндромом
  defp palindrome?(n) do
    str_n = Integer.to_string(n)
    str_n == String.reverse(str_n)
  end

  def largest_palindrome_map do
    100..999
    |> Enum.flat_map(fn i ->
      Enum.map(100..999, fn j -> i * j end)
    end)
    |> Enum.filter(&palindrome?/1)
    |> Enum.max()
  end
end
```

### Решение через работу со спец. синтаксисом для циклов (for)

```elixir
defmodule Task4.Cycle do
  @moduledoc "4. Специальный синтаксис для циклов (for)"
  # Проверка, является ли число палиндромом
  defp palindrome?(n) do
    str_n = Integer.to_string(n)
    str_n == String.reverse(str_n)
  end

  def largest_palindrome_cycle do
    for i <- 999..100//-1,
        j <- 999..100//-1,
        product = i * j,
        palindrome?(product) do
      product
    end
    |> Enum.max()
  end
end
```

### Решение через бесконечные структуры и ленивые коллекции (Stream)

```elixir
defmodule Task4.Lazy do
  @moduledoc "5. Ленивое выполнение с использованием Stream"
  # Проверка, является ли число палиндромом
  defp palindrome?(n) do
    str_n = Integer.to_string(n)
    str_n == String.reverse(str_n)
  end

  def largest_palindrome_lazy do
    Stream.flat_map(999..100//-1, fn i ->
      Stream.map(999..100//-1, fn j -> i * j end)
    end)
    |> Stream.filter(&palindrome?/1)
    |> Enum.max()
  end
end
```

### Решение через удобный для меня традиционный язык программирования для сравнения (Python)

```python
def is_palindrome(n):
    return str(n) == str(n)[::-1]

def find_largest_palindrome():
    max_p = 0
    for i in range(999, 99, -1):
        for j in range(999, 99, -1):
            product = i * j
            if product > max_p and is_palindrome(product):
                max_p = product
    return max_p


if __name__ == "__main__":
    print(find_largest_palindrome())
```

---

## Проблема №27
