defmodule Lab1Test do
  use ExUnit.Case

  doctest Task4.TailRecursion
  doctest Task4.UsualRecursion
  doctest Task4.Modular
  doctest Task4.Map4
  doctest Task4.Cycle
  doctest Task4.Lazy

  doctest Task27.TailRecursion
  doctest Task27.UsualRecursion
  doctest Task27.Modular
  doctest Task27.Map27
  doctest Task27.Cycle
  doctest Task27.Lazy

  test "Task 4 Tail Recursion" do
    assert Task4.TailRecursion.largest_palindrome_tail_recur() == 906_609
  end

  test "Task 4 Usual Recursion" do
    assert Task4.UsualRecursion.largest_palindrome_usual_recur() == 906_609
  end

  test "Task 4 Modular" do
    assert Task4.Modular.largest_palindrome_modular() == 906_609
  end

  test "Task 4 Map4" do
    assert Task4.Map4.largest_palindrome_map() == 906_609
  end

  test "Task 4 Cycle" do
    assert Task4.Cycle.largest_palindrome_cycle() == 906_609
  end

  test "Task 4 Lazy" do
    assert Task4.Lazy.largest_palindrome_lazy() == 906_609
  end

  test "Task 27 Tail Recursion" do
    assert Task27.TailRecursion.quadratic_primes_tail_recur() == %{
             count: 71,
             product: -59_231,
             a: -61,
             b: 971
           }
  end

  test "Task 27 Usual Recursion" do
    assert Task27.UsualRecursion.quadratic_primes_usual_recur() == %{
             count: 71,
             product: -59_231,
             a: -61,
             b: 971
           }
  end

  test "Task 27 Modular" do
    assert Task27.Modular.quadratic_primes_modular() == %{
             count: 71,
             product: -59_231,
             a: -61,
             b: 971
           }
  end

  test "Task 27 Map27" do
    assert Task27.Map27.quadratic_primes_map() == %{count: 71, product: -59_231, a: -61, b: 971}
  end

  test "Task 27 Cycle" do
    assert Task27.Cycle.quadratic_primes_cycle() == %{count: 71, product: -59_231, a: -61, b: 971}
  end

  test "Task 27 Lazy" do
    assert Task27.Lazy.quadratic_primes_lazy() == %{count: 71, product: -59_231, a: -61, b: 971}
  end
end
