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