defmodule Task4Test do
  use ExUnit.Case

  doctest TailRecursion
  doctest UsualRecursion
  doctest Modular
  doctest Lazy

  test "Tail Recursion" do
    assert TailRecursion.quadratic_primes_tail_recur() == %{count: 71, product: -59231, a: -61, b: 971}
  end

  test "Usual Recursion" do
    assert UsualRecursion.quadratic_primes_usual_recur() == %{count: 71, product: -59231, a: -61, b: 971}
  end

  test "Modular" do
    assert Modular.quadratic_primes_modular() == %{count: 71, product: -59231, a: -61, b: 971}
  end

  test "Lazy" do
    assert Lazy.quadratic_primes_lazy() == %{count: 71, product: -59231, a: -61, b: 971}
  end
end
