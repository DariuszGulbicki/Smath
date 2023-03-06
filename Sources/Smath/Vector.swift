import Foundation

infix operator ===: ComparisonPrecedence
prefix operator %
prefix operator ~
prefix operator +
prefix operator -
prefix operator |
prefix operator ||
prefix operator ∑

public class Vector: ExpressibleByArrayLiteral, CustomStringConvertible {

    public var elements: [Double]

    public var description: String {
        return "Vector(\(elements))"
    }

    public init() {
        self.elements = []
    }

    public init(elements: [Double]) {
        self.elements = elements
    }

    public init(count: Int, repeatedValue: Double) {
        self.elements = Array(repeating: repeatedValue, count: count)
    }

    public required init(arrayLiteral elements: Double...) {
        self.elements = elements
    }

    public subscript(index: Int) -> Double {
        get {
            return elements[index]
        }
        set {
            elements[index] = newValue
        }
    }

    // Generic operations

    public var count: Int {
        return elements.count
    }

    public var rounded: Vector {
        return Vector(elements: elements.map { $0.rounded() })
    }

    public func map(_ transform: (Double) throws -> Double) rethrows -> Vector {
        return Vector(elements: try elements.map(transform))
    }

    public func filter(_ isIncluded: (Double) throws -> Bool) rethrows -> Vector {
        return Vector(elements: try elements.filter(isIncluded))
    }

    public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Double) throws -> Result) rethrows -> Result {
        return try elements.reduce(initialResult, nextPartialResult)
    }

    public func forEach(_ body: (Double) throws -> Void) rethrows {
        try elements.forEach(body)
    }

    // Equatable operations

    public func isEqual(_ to: Vector) -> Bool {
        if count != to.count {
            return false
        }
        for i in 0..<count {
            if self[i] != to[i] {
                return false
            }
        }
        return true
    }

    public static func ==(lhs: Vector, rhs: Vector) -> Bool {
        return lhs.isEqual(rhs)
    }

    public static func !=(lhs: Vector, rhs: Vector) -> Bool {
        return !lhs.isEqual(rhs)
    }

    public func isApproximatelyEqual(_ to: Vector, tolerance: Double = 1e-6) -> Bool {
        if count != to.count {
            return false
        }
        for i in 0..<count {
            if abs(self[i] - to[i]) > tolerance {
                return false
            }
        }
        return true
    }

    public static func ===(lhs: Vector, rhs: Vector) -> Bool {
        return lhs.isApproximatelyEqual(rhs)
    }

    // Arithmetic operations

    public func add(_ vector: Vector) -> Vector {
        let output = Vector(count: count, repeatedValue: 0)
        for i in 0..<count {
            output[i] = self[i] + vector[i]
        }
        return output
    }

    public static func +(_ lhs: Vector, _ rhs: Vector) -> Vector {
        return lhs.add(rhs)
    }

    public func add(_ scalar: Double) -> Vector {
        let output = Vector(count: count, repeatedValue: 0)
        for i in 0..<count {
            output[i] = self[i] + scalar
        }
        return output
    }

    public static func +(_ lhs: Vector, _ rhs: Double) -> Vector {
        return lhs.add(rhs)
    }

    public func subtract(_ vector: Vector) -> Vector {
        let output = Vector(count: count, repeatedValue: 0)
        for i in 0..<count {
            output[i] = self[i] - vector[i]
        }
        return output
    }

    public static func -(_ lhs: Vector, _ rhs: Vector) -> Vector {
        return lhs.subtract(rhs)
    }

    public func subtract(_ scalar: Double) -> Vector {
        let output = Vector(count: count, repeatedValue: 0)
        for i in 0..<count {
            output[i] = self[i] - scalar
        }
        return output
    }

    public static func -(_ lhs: Vector, _ rhs: Double) -> Vector {
        return lhs.subtract(rhs)
    }

    public func multiply(_ vector: Vector) -> Vector {
        let output = Vector(count: count, repeatedValue: 0)
        for i in 0..<count {
            output[i] = self[i] * vector[i]
        }
        return output
    }

    public static func *(_ lhs: Vector, _ rhs: Vector) -> Vector {
        return lhs.multiply(rhs)
    }

    public func multiply(_ scalar: Double) -> Vector {
        let output = Vector(count: count, repeatedValue: 0)
        for i in 0..<count {
            output[i] = self[i] * scalar
        }
        return output
    }

    public static func *(_ lhs: Vector, _ rhs: Double) -> Vector {
        return lhs.multiply(rhs)
    }

    public func divide(_ vector: Vector) -> Vector {
        let output = Vector(count: count, repeatedValue: 0)
        for i in 0..<count {
            output[i] = self[i] / vector[i]
        }
        return output
    }

    public static func /(_ lhs: Vector, _ rhs: Vector) -> Vector {
        return lhs.divide(rhs)
    }

    public func divide(_ scalar: Double) -> Vector {
        let output = Vector(count: count, repeatedValue: 0)
        for i in 0..<count {
            output[i] = self[i] / scalar
        }
        return output
    }

    public static func /(_ lhs: Vector, _ rhs: Double) -> Vector {
        return lhs.divide(rhs)
    }

    public func power(_ vector: Vector) -> Vector {
        let output = Vector(count: count, repeatedValue: 0)
        for i in 0..<count {
            output[i] = pow(self[i], vector[i])
        }
        return output
    }

    public static func ^(_ lhs: Vector, _ rhs: Vector) -> Vector {
        return lhs.power(rhs)
    }

    public func power(_ scalar: Double) -> Vector {
        let output = Vector(count: count, repeatedValue: 0)
        for i in 0..<count {
            output[i] = pow(self[i], scalar)
        }
        return output
    }

    public static func ^(_ lhs: Vector, _ rhs: Double) -> Vector {
        return lhs.power(rhs)
    }

    public func root(_ vector: Vector) -> Vector {
        let output = Vector(count: count, repeatedValue: 0)
        for i in 0..<count {
            output[i] = pow(self[i], 1 / vector[i])
        }
        return output
    }
    
    public static func %(_ lhs: Vector, _ rhs: Vector) -> Vector {
        return lhs.root(rhs)
    }

    public func root(_ scalar: Double) -> Vector {
        let output = Vector(count: count, repeatedValue: 0)
        for i in 0..<count {
            output[i] = pow(self[i], 1 / scalar)
        }
        return output
    }

    public static func %(_ lhs: Vector, _ rhs: Double) -> Vector {
        return lhs.root(rhs)
    }

    public func squareRoot() -> Vector {
        return power(0.5)
    }

    public static prefix func %(_ vector: Vector) -> Vector {
        return vector.squareRoot()
    }

    // Vector specific operations

    public func sum() -> Double {
        return elements.reduce(0, +)
    }

    public static prefix func ∑(_ vector: Vector) -> Double {
        return vector.sum()
    }

    public static prefix func +(_ vector: Vector) -> Double {
        return vector.sum()
    }

    public func mean() -> Double {
        return sum() / Double(count)
    }

    public static prefix func |(_ vector: Vector) -> Double {
        return vector.mean()
    }

    public func std() -> Double {
        let mean = self.mean()
        let squaredDifferences = map { pow($0 - mean, 2) }
        return sqrt(squaredDifferences.sum() / Double(count))
    }

    public static prefix func ||(_ vector: Vector) -> Double {
        return vector.std()
    }

    public func normalize() -> Vector {
        let mean = self.mean()
        let std = self.std()
        return map { ($0 - mean) / std }
    }

    public static prefix func ~(_ vector: Vector) -> Vector {
        return vector.normalize()
    }

    public func dot(_ vector: Vector) -> Double {
        return zip(elements, vector.elements).map(*).reduce(0, +)
    }

    public func transpose() -> Matrix {
        return Matrix(rows: count, columns: 1, elements: elements)
    }

    public func toMatrix() -> Matrix {
        return Matrix(rows: 1, columns: count, elements: elements)
    }

    public func toMatrix(rows: Int, columns: Int) -> Matrix {
        return Matrix(rows: rows, columns: columns, elements: elements)
    }

    public func toMatrix(rows: Int, columns: Int, repeatedValue: Double) -> Matrix {
        return Matrix(rows: rows, columns: columns, elements: Array(repeating: repeatedValue, count: rows * columns))
    }

    public func toMatrix(rows: Int, columns: Int, elements: [Double]) -> Matrix {
        return Matrix(rows: rows, columns: columns, elements: elements)
    }

    public func toMatrix(rows: Int, columns: Int, elements: [Double], repeatedValue: Double) -> Matrix {
        return Matrix(rows: rows, columns: columns, elements: elements + Array(repeating: repeatedValue, count: rows * columns - elements.count))
    }

}