public struct ShutterSpeed {
    
    public let numerator: Int
    
    public let denominator: Int

    public init?(numerator: Int, denominator: Int) {
        
        let divisor = gcd(numerator, denominator)
        
        guard 0 != divisor else {
            return nil
        }
        
        let n = Int(abs(numerator / divisor))
        let d = Int(abs(denominator / divisor))
        let sign = numerator * denominator > 0 ? 1 : -1
        
        self.numerator = sign * n
        self.denominator = d
    }
}


extension ShutterSpeed {

    public static var second: ShutterSpeed = ShutterSpeed(numerator: 1, denominator: 1)!
}


extension ShutterSpeed : Equatable {
    
    public static func ==(lhs: ShutterSpeed, rhs: ShutterSpeed) -> Bool {
        return lhs.numerator == rhs.numerator && lhs.denominator == rhs.denominator
    }
}

extension ShutterSpeed : Hashable {
    
    public var hashValue: Int {
        return numerator.hashValue ^ denominator.hashValue
    }
}

extension ShutterSpeed : Comparable {

    public static func <(lhs: ShutterSpeed, rhs: ShutterSpeed) -> Bool {
        let ln = lhs.numerator * rhs.denominator
        let rn = rhs.numerator * lhs.denominator
        
        return ln < rn
    }
}
