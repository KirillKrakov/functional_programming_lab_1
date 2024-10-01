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