defmodule Task4Test do
  use ExUnit.Case

  doctest TailRecursion
  doctest UsualRecursion
  doctest Modular
  doctest Lazy

  test "Tail Recursion" do
    assert TailRecursion.largest_palindrome_tail_recur() == 906609
  end

  test "Usual Recursion" do
    assert UsualRecursion.largest_palindrome_usual_recur() == 906609
  end

  test "Modular" do
    assert Modular.largest_palindrome_modular() == 906609
  end

  test "Lazy" do
    assert Lazy.largest_palindrome_lazy() == 906609
  end
end
