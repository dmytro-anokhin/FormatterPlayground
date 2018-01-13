/** Greatest common divisor of two integers.
 
    The greatest common divisor (gcd) of two or more integers, which are not all zero, is the largest positive integer that divides each of the integers. For example, the gcd of 8 and 12 is 4.
*/
public func gcd<T>(_ a: T, _ b: T) -> T where T : BinaryInteger, T : SignedNumeric {

    var a = abs(a)
    var b = abs(b)

    if a == 0 || b == 0 {
        return 0
    }
    
    if a == 1 || b == 1 {
        return 1
    }

    if b > a {
        swap(&a, &b)
    }
    
    while b > 0 {
        (a, b) = (b, a % b)
    }
    
    return a
}
