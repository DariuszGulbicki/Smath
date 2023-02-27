import Foundation

//infix operator +
//infix operator -
//infix operator *
//infix operator /
//infix operator ^
//infix operator %
prefix operator !
prefix operator ~
prefix operator |
prefix operator %

public class Matrix {

    public var rows: Int
    public var columns: Int
    public var elements: [Double]
    
    public init(rows: Int, columns: Int, elements: [Double]) {
        self.rows = rows
        self.columns = columns
        self.elements = elements
    }
    
    public init(rows: Int, columns: Int, repeatedValue: Double) {
        self.rows = rows
        self.columns = columns
        self.elements = [Double](repeating: repeatedValue, count: rows * columns)
    }
    
    public init(rows: Int, columns: Int, generator: (Int, Int) -> Double) {
        self.rows = rows
        self.columns = columns
        self.elements = [Double](repeating: 0, count: rows * columns)
        
        for i in 0..<rows {
            for j in 0..<columns {
                self[i, j] = generator(i, j)
            }
        }
    }

    public init (rows: Int, columns: Int, values: Double...) {
        self.rows = rows
        self.columns = columns
        self.elements = values
    }

    public init (rows: Int, columns: Int, elements: [[Double]]) {
        self.rows = rows
        self.columns = columns
        self.elements = [Double](repeating: 0, count: rows * columns)
        for i in 0..<rows {
            for j in 0..<columns {
                self[i, j] = elements[i][j]
            }
        }
    }
    
    public subscript(row: Int, column: Int) -> Double {
        get {
            return elements[(row * columns) + column]
        }
        set {
            elements[(row * columns) + column] = newValue
        }
    }
    
    public func map(_ transform: (Double) -> Double) -> Matrix {
        return Matrix(rows: rows, columns: columns) { i, j in
            return transform(self[i, j])
        }
    }
    
    public func map(_ transform: (Int, Int, Double) -> Double) -> Matrix {
        return Matrix(rows: rows, columns: columns) { i, j in
            return transform(i, j, self[i, j])
        }
    }

    public func isEqual(_ matrix: Matrix) -> Bool {
        if self.rows != matrix.rows || self.columns != matrix.columns {
            return false
        }
        for i in 0..<self.rows {
            for j in 0..<self.columns {
                if self[i, j] != matrix[i, j] {
                    return false
                }
            }
        }
        return true
    }

    public func isNotEqual(_ matrix: Matrix) -> Bool {
        return !self.isEqual(matrix)
    }

    public static func ==(lhs: Matrix, rhs: Matrix) -> Bool {
        return lhs.isEqual(rhs)
    }

    public static func !=(lhs: Matrix, rhs: Matrix) -> Bool {
        return lhs.isNotEqual(rhs)
    }

    public func add(_ matrix: Matrix) -> Matrix {
        return self.map { i, j, value in
            return value + matrix[i, j]
        }
    }

    public static func +(lhs: Matrix, rhs: Matrix) -> Matrix {
        return lhs.map { i, j, value in
            return value + rhs[i, j]
        }
    }

    public func add(_ scalar: Double) -> Matrix {
        return self.map { $0 + scalar }
    }

    public static func +(lhs: Matrix, rhs: Double) -> Matrix {
        return lhs.map { $0 + rhs }
    }

    public func subtract(_ matrix: Matrix) -> Matrix {
        return self.map { i, j, value in
            return value - matrix[i, j]
        }
    }

    public static func -(lhs: Matrix, rhs: Matrix) -> Matrix {
        return lhs.map { i, j, value in
            return value - rhs[i, j]
        }
    }

    public func subtract(_ scalar: Double) -> Matrix {
        return self.map { $0 - scalar }
    }

    public static func -(lhs: Matrix, rhs: Double) -> Matrix {
        return lhs.map { $0 - rhs }
    }

    public func multiply(_ matrix: Matrix) -> Matrix {
        return Matrix(rows: rows, columns: matrix.columns) { i, j in
            var sum = 0.0
            for k in 0..<self.columns {
                sum += self[i, k] * matrix[k, j]
            }
            return sum
        }
    }

    public static func *(lhs: Matrix, rhs: Matrix) -> Matrix {
        return Matrix(rows: lhs.rows, columns: rhs.columns) { i, j in
            var sum = 0.0
            for k in 0..<lhs.columns {
                sum += lhs[i, k] * rhs[k, j]
            }
            return sum
        }
    }

    public func multiply(_ scalar: Double) -> Matrix {
        return self.map { $0 * scalar }
    }

    public static func *(lhs: Matrix, rhs: Double) -> Matrix {
        return lhs.map { $0 * rhs }
    }

    public func divide(_ matrix: Matrix) -> Matrix {
        return self.map { i, j, value in
            return value / matrix[i, j]
        }
    }

    public static func /(lhs: Matrix, rhs: Matrix) -> Matrix {
        return lhs.map { i, j, value in
            return value / rhs[i, j]
        }
    }

    public func divide(_ scalar: Double) -> Matrix {
        return self.map { $0 / scalar }
    }

    public static func /(lhs: Matrix, rhs: Double) -> Matrix {
        return lhs.map { $0 / rhs }
    }

    public func power(_ exponent: Matrix) -> Matrix {
        var output = self
        for i in 0..<rows {
            for j in 0..<columns {
                output[i, j] = pow(self[i, j], exponent[i, j])
            }
        }
        return self
    }

    public static func ^(lhs: Matrix, rhs: Matrix) -> Matrix {
        return lhs.power(rhs)
    }

    public func power(_ exponent: Double) -> Matrix {
        return self.map { pow($0, exponent) }
    }

    public static func ^(lhs: Matrix, rhs: Double) -> Matrix {
        return lhs.map { pow($0, rhs) }
    }

    public func root(_ root: Matrix) -> Matrix {
        var output = self
        for i in 0..<rows {
            for j in 0..<columns {
                output[i, j] = pow(self[i, j], 1 / root[i, j])
            }
        }
        return self
    }

    public static func %(lhs: Matrix, rhs: Matrix) -> Matrix {
        return lhs.root(rhs)
    }

    public static prefix func %(matrix: Matrix) -> Matrix {
        return matrix.map { pow($0, 1 / 2) }
    }

    public func root(_ root: Double) -> Matrix {
        return self.map { pow($0, 1 / root) }
    }

    public static func %(lhs: Matrix, rhs: Double) -> Matrix {
        return lhs.map { pow($0, 1 / rhs) }
    }

    public func transpose() -> Matrix {
        return Matrix(rows: columns, columns: rows) { i, j in
            return self[j, i]
        }
    }

    public static prefix func ~(matrix: Matrix) -> Matrix {
        return matrix.transpose()
    }

    public func dot(_ matrix: Matrix) -> Matrix {
        return self * matrix
    }

    public static func determinant(_ matrix: Matrix) -> Double {
        if matrix.rows == 1 && matrix.columns == 1 {
            return matrix[0, 0]
        }
        
        var sum = 0.0
        for i in 0..<matrix.columns {
            sum += matrix[0, i] * Matrix.cofactor(matrix, row: 0, column: i)
        }
        return sum
    }

    public static prefix func |(matrix: Matrix) -> Double {
        return Matrix.determinant(matrix)
    }

    public static func adjugate(_ matrix: Matrix) -> Matrix {
        var elements = [Double]()
        for i in 0..<matrix.rows {
            for j in 0..<matrix.columns {
                elements.append(Matrix.cofactor(matrix, row: i, column: j))
            }
        }
        return Matrix(rows: matrix.rows, columns: matrix.columns, elements: elements).transpose()
    }

    public static func cofactor(_ matrix: Matrix, row: Int, column: Int) -> Double {
        return pow(-1, Double(row + column)) * |Matrix.minor(matrix, row: row, column: column)
    }

    public static func minor(_ matrix: Matrix, row: Int, column: Int) -> Matrix {
        var elements = [Double]()
        for i in 0..<matrix.rows {
            for j in 0..<matrix.columns {
                if i != row && j != column {
                    elements.append(matrix[i, j])
                }
            }
        }
        return Matrix(rows: matrix.rows - 1, columns: matrix.columns - 1, elements: elements)
    }

    public func inverse() -> Matrix {
        let determinant = Matrix.determinant(self)
        if determinant == 0 {
            return Matrix(rows: rows, columns: columns, repeatedValue: 0)
        }
        
        var elements = [Double]()
        for i in 0..<rows {
            for j in 0..<columns {
                elements.append(Matrix.cofactor(self, row: i, column: j) / determinant)
            }
        }
        return Matrix(rows: rows, columns: columns, elements: elements).transpose()
    }

    public static prefix func !(matrix: Matrix) -> Matrix {
        return matrix.inverse()
    }

    public static prefix func -(matrix: Matrix) -> Matrix {
        return matrix.map { -$0 }
    }
    
}

