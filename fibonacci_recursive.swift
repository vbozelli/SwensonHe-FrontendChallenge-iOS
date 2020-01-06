func fibonacci_recursive(n: Int) -> Int {
    if n < 2 {
        return 1
    }
    return fibonacci_recursive(n: n - 1) + fibonacci_recursive(n: n - 2)
}