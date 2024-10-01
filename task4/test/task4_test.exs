defmodule Task4Test do
  use ExUnit.Case

  import Task4

  test "palindrome number identification" do
    assert palindrome?(9009) == true
    assert palindrome?(12321) == true
    assert palindrome?(12345) == false
    assert palindrome?(1) == true
    assert palindrome?(11) == true
    assert palindrome?(10) == false
  end

  test "all implementations should return the same result" do
    expected = 906609

    assert largest_palindrome_tail_recur() == expected
    assert largest_palindrome_usual_recur() == expected
    assert largest_palindrome_modular() == expected
    assert largest_palindrome_map() == expected
    assert largest_palindrome_reduce() == expected
    assert largest_palindrome_lazy() == expected
  end
end
