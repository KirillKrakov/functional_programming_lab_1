defmodule Task4Test do
  use ExUnit.Case

  import TailRecursion
  import UsualRecursion
  import Modular
  import Lazy

  test "Tail Recursion" do
    assert largest_palindrome_tail_recur() == 906609
  end

  test "Usual Recursion" do
    assert largest_palindrome_usual_recur() == 906609
  end

  test "Modular" do
    assert largest_palindrome_modular() == 906609
  end

  test "Lazy" do
    assert largest_palindrome_lazy() == 906609
  end
end
