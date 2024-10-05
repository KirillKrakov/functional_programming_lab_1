defmodule Task4Test do
  use ExUnit.Case

  import TailRecursion
  import UsualRecursion
  import Modular
  doctest Map4
  import Lazy

  test "Tail Recursion" do
    assert largest_palindrome_tail_recur() == 906_609
  end

  test "Usual Recursion" do
    assert largest_palindrome_usual_recur() == 906_609
  end

  test "Modular" do
    assert largest_palindrome_modular() == 906_609
  end

  test "Map4" do
    assert Map4.largest_palindrome_map() == 906_609
  end

  test "Lazy" do
    assert largest_palindrome_lazy() == 906_609
  end
end
