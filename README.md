# Лабораторная работа по функциональному программированию №1
## Проект Эйлера №4, №27

---

  * Студент: `Краков Кирилл Константинович`
  * Группа: `P3331`
  * ИСУ: `368373`
  * Функциональный язык: `Elixir`

---

## Проблема №4

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
  # В реальности for отвечает за списковые включения, а не циклы.
  # Фактически в Elixir спец. синтаксиса для циклов нет.
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

  * **Название**: `Quadratic Primes`
  * **Описание**:
    <p>Euler discovered the remarkable quadratic formula:</p>
    <p class="center">$n^2 + n + 41$</p>
    <p>It turns out that the formula will produce $40$ primes for the consecutive integer values $0 \le n \le 39$. However, when $n = 40, 40^2 + 40 + 41 = 40(40 + 1) + 41$ is divisible by $41$, and certainly when $n = 41, 41^2 + 41 + 41$ is clearly divisible by $41$.</p>
    <p>The incredible formula $n^2 - 79n + 1601$ was discovered, which produces $80$ primes for the consecutive values $0 \le n \le 79$. The product of the coefficients, $-79$ and $1601$, is $-126479$.</p>
    <p>Considering quadratics of the form:</p>
    <blockquote>
    $n^2 + an + b$, where $|a| &lt; 1000$ and $|b| \le 1000$<br><br><div>where $|n|$ is the modulus/absolute value of $n$<br>e.g. $|11| = 11$ and $|-4| = 4$</div>
    </blockquote> 

  * **Задание**: Find the product of the coefficients, $a$ and $b$, for the quadratic expression that produces the maximum number of primes for consecutive values of $n$, starting with $n = 0$.

---

### Основная идея решения

Также решим задачу перебором. перебираем числа a и b в заданном для них диапазоне. Для каждой пары a и b считаем количество подряд идущих n, которые при подстановке в формулу $n^2 - an + b$ дадут простое число. Сравниваем получившееся число с текущим максимальным значением и находим из них наибольший. В итоге находим пару a и b, для которых получившееся количество n будет максимальным. Вычисляем произведение a и b.

---

### Решение через хвостовую рекурсию

```elixir
defmodule Task27.TailRecursion do
  @moduledoc "1.1 Хвостовая рекурсия"
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

  def quadratic_primes_tail_recur do
    quadratic_primes_tail_recur(-999, -1000, 0, {0, 0})
  end

  defp quadratic_primes_tail_recur(a, b, max_count, max_coeffs) do
    cond do
      a > 1000 ->
        %{
          product: elem(max_coeffs, 0) * elem(max_coeffs, 1),
          a: elem(max_coeffs, 0),
          b: elem(max_coeffs, 1),
          count: max_count
        }

      b > 1001 ->
        quadratic_primes_tail_recur(a + 1, -1000, max_count, max_coeffs)

      true ->
        count = count_primes(a, b)

        if count > max_count do
          quadratic_primes_tail_recur(a, b + 1, count, {a, b})
        else
          quadratic_primes_tail_recur(a, b + 1, max_count, max_coeffs)
        end
    end
  end
end
```

### Решение через обычную рекурсию 

```elixir
defmodule Task27.UsualRecursion do
  @moduledoc "1.2 Обычная рекурсия"
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

  def quadratic_primes_usual_recur do
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
```

### Решение через модульность (reduce, filter, map)

```elixir
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
```

### Решение через генерацию последовательности при помощи отображения (map)

```elixir
defmodule Task27.Map27 do
  @moduledoc "3. Генерация последовательности при помощи отображения (map)"
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

  def quadratic_primes_map do
    a_range = -999..999
    b_range = -1000..1000

    combinations = for a <- a_range, b <- b_range, do: {a, b}

    combinations
    |> Enum.map(fn {a, b} ->
      %{product: a * b, a: a, b: b, count: count_primes(a, b)}
    end)
    |> Enum.filter(&(&1.count > 0))
    |> Enum.max_by(& &1.count)
  end
end
```

### Решение через работу со спец. синтаксисом для циклов (for)

```elixir
defmodule Task27.Cycle do
  @moduledoc "4. Специальный синтаксис для циклов (for)"
  # В реальности for отвечает за списковые включения, а не циклы.
  # Фактически в Elixir спец. синтаксиса для циклов нет.
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

  def quadratic_primes_cycle do
    for a <- -999..999,
        b <- -1000..1000,
        into: [] do
      %{product: a * b, a: a, b: b, count: count_primes(a, b)}
    end
    |> Enum.filter(&(&1.count > 0))
    |> Enum.max_by(& &1.count)
  end
end
```

### Решение через бесконечные структуры и ленивые коллекции (Stream)

```elixir
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
```

### Решение через удобный для меня традиционный язык программирования для сравнения (Python)

```python
from functools import lru_cache

@lru_cache(maxsize=None)
def is_prime(n):
    if n < 2:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True


def count_primes(a, b):
    n = 0
    while is_prime(n*n + a*n + b):
        n += 1
    return n


def find_max_count():
    max_count = 0
    max_coeffs = (0, 0)

    for a in range(-999, 1000):
        for b in range(-1000, 1001):
            count = count_primes(a, b)
            if count > max_count:
                max_count = count
                max_coeffs = (a, b)

    return max_coeffs


if __name__ == "__main__":
    a, b = find_max_count()
    print(f"Произведение коэффициентов: {a*b}")
    print(f"Коэффициенты: a = {a}, b = {b}")
    print(f"Максимальное количество простых чисел (n): {count_primes(a, b)}")
```

---

## Выводы

Работа над задачами из Project Euler позволила мне глубже понять и освоить основные концепции функционального программирования. Использование различных подходов, таких как хвостовая рекурсия, модульная реализация, отображение и работа с ленивыми коллекциями позволило глубже понять особенности и преимущества функционального стиля.

Применение хвостовой рекурсии и ленивых коллекций позволило эффективно работать с большими объемами данных, избегая переполнения стека и излишнего потребления памяти.

Использование функций высшего порядка (map, filter, reduce) значительно упростило обработку последовательностей данных, делая код более лаконичным и выразительным.
