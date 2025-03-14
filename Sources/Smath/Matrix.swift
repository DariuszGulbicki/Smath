import Foundation

infix operator ===
prefix operator !
prefix operator ~
prefix operator |
prefix operator %
prefix operator *

public class Matrix: ExpressibleByArrayLiteral, CustomStringConvertible {

    public var rows: Int
    public var columns: Int
    public var elements: [Double]

    public var count: Int {
        return rows * columns
    }

    public var invertible: Bool {
        return |self != 0
    }

    public var identity: Matrix {
        return Matrix(rows: rows, columns: columns, generator: { (i, j) -> Double in
            return i == j ? 1 : 0
        })
    }

    public var description: String {
        var description = ""
        for i in 0..<rows {
            for j in 0..<columns {
                description += "\(self[i, j]) "
            }
            description += " | "
        }
        return description
    }
    
    public init(rows: Int, columns: Int, elements: [Double]) {
        precondition(rows > 0, "Rows must be greater than 0")
        precondition(columns > 0, "Columns must be greater than 0")
        precondition(elements.count == rows * columns, "Number of elements must equal rows * columns")
        self.rows = rows
        self.columns = columns
        self.elements = elements
    }
    
    public init(rows: Int, columns: Int, repeatedValue: Double) {
        precondition(rows > 0, "Rows must be greater than 0")
        precondition(columns > 0, "Columns must be greater than 0")
        self.rows = rows
        self.columns = columns
        self.elements = [Double](repeating: repeatedValue, count: rows * columns)
    }
    
    public init(rows: Int, columns: Int, generator: (Int, Int) -> Double) {
        precondition(rows > 0, "Rows must be greater than 0")
        precondition(columns > 0, "Columns must be greater than 0")
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
        precondition(rows > 0, "Rows must be greater than 0")
        precondition(columns > 0, "Columns must be greater than 0")
        precondition(values.count == rows * columns, "Number of elements must equal rows * columns")
        self.rows = rows
        self.columns = columns
        self.elements = values
    }

    public init (rows: Int, columns: Int, elements: [[Double]]) {
        precondition(rows > 0, "Rows must be greater than 0")
        precondition(columns > 0, "Columns must be greater than 0")
        precondition(elements.count == rows, "Number of rows must equal rows")
        self.rows = rows
        self.columns = columns
        self.elements = [Double](repeating: 0, count: rows * columns)
        for i in 0..<rows {
            for j in 0..<columns {
                self[i, j] = elements[i][j]
            }
        }
    }

    public required init(arrayLiteral elements: [Double]...) {
        precondition(elements.count > 0, "Rows must be greater than 0")
        precondition(elements[0].count > 0, "Columns must be greater than 0")
        self.rows = elements.count
        self.columns = elements[0].count
        self.elements = [Double](repeating: 0, count: rows * columns)
        for i in 0..<rows {
            for j in 0..<columns {
                self[i, j] = elements[i][j]
            }
        }
    }

    public required init(_ elements: [[Double]]) {
        precondition(elements.count > 0, "Rows must be greater than 0")
        precondition(elements[0].count > 0, "Columns must be greater than 0")
        self.rows = elements.count
        self.columns = elements[0].count
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

    public func isApproximatelyEqual(_ matrix: Matrix, tolerance: Double) -> Bool {
        if self.rows != matrix.rows || self.columns != matrix.columns {
            return false
        }
        for i in 0..<self.rows {
            for j in 0..<self.columns {
                if abs(self[i, j] - matrix[i, j]) > tolerance {
                    return false
                }
            }
        }
        return true
    }

    public func isZero() -> Bool {
        for i in 0..<self.rows {
            for j in 0..<self.columns {
                if self[i, j] != 0 {
                    return false
                }
            }
        }
        return true
    }

    public static func ==(lhs: Matrix, rhs: Matrix) -> Bool {
        return lhs.isEqual(rhs)
    }

    public static func ===(lhs: Matrix, rhs: Matrix) -> Bool {
        return lhs.isApproximatelyEqual(rhs, tolerance: 0.1)
    }

    public static func !=(lhs: Matrix, rhs: Matrix) -> Bool {
        return !lhs.isEqual(rhs)
    }

    public func isSquare() -> Bool {
        return self.rows == self.columns
    }

    public func hasSameDimensions(_ matrix: Matrix) -> Bool {
        return self.rows == matrix.rows && self.columns == matrix.columns
    }

    public func getDiagonal() -> Matrix {
        if self.isSquare() {
            return Matrix(rows: self.rows, columns: self.columns) { i, j in
                if i == j {
                    return self[i, j]
                } else {
                    return 0
                }
            }
        } else {
            preconditionFailure("Matrix must be square")
        }
    }

    public func getLowerTriangle() -> Matrix {
        if self.isSquare() {
            return Matrix(rows: self.rows, columns: self.columns) { i, j in
                if i >= j {
                    return self[i, j]
                } else {
                    return 0
                }
            }
        } else {
            preconditionFailure("Matrix must be square")
        }
    }

    public func getUpperTriangle() -> Matrix {
        if self.isSquare() {
            return Matrix(rows: self.rows, columns: self.columns) { i, j in
                if i <= j {
                    return self[i, j]
                } else {
                    return 0
                }
            }
        } else {
            preconditionFailure("Matrix must be square")
        }
    }

    public func getRow(_ row: Int) -> Matrix {
        if row >= self.rows || row < 0 {
            preconditionFailure("Row index out of bounds")
        }
        return Matrix(rows: 1, columns: self.columns) { i, j in
            return self[row, j]
        }
    }

    public func getColumn(_ column: Int) -> Matrix {
        if column >= self.columns || column < 0 {
            preconditionFailure("Column index out of bounds")
        }
        return Matrix(rows: self.rows, columns: 1) { i, j in
            return self[i, column]
        }
    }

    public func getSubMatrix(_ rowStart: Int, _ rowEnd: Int, _ columnStart: Int, _ columnEnd: Int) -> Matrix {
        if rowStart > rowEnd || columnStart > columnEnd || rowStart < 0 || rowEnd >= self.rows || columnStart < 0 || columnEnd >= self.columns {
            preconditionFailure("Invalid submatrix indices")
        }
        return Matrix(rows: rowEnd - rowStart + 1, columns: columnEnd - columnStart + 1) { i, j in
            return self[rowStart + i, columnStart + j]
        }
    }

    public func getSubMatrix(_ rowIndices: [Int], _ columnIndices: [Int]) -> Matrix {
        if rowIndices.max()! >= self.rows || rowIndices.min()! < 0 || columnIndices.max()! >= self.columns || columnIndices.min()! < 0 {
            preconditionFailure("Invalid submatrix indices")
        }
        return Matrix(rows: rowIndices.count, columns: columnIndices.count) { i, j in
            return self[rowIndices[i], columnIndices[j]]
        }
    }

    public func getSubMatrix(_ rowIndices: [Int], _ columnStart: Int, _ columnEnd: Int) -> Matrix {
        if columnStart > columnEnd || columnStart < 0 || columnEnd >= self.columns || rowIndices.max()! >= self.rows || rowIndices.min()! < 0 {
            preconditionFailure("Invalid submatrix indices")
        }
        return Matrix(rows: rowIndices.count, columns: columnEnd - columnStart + 1) { i, j in
            return self[rowIndices[i], columnStart + j]
        }
    }

    public func getSubMatrix(_ rowStart: Int, _ rowEnd: Int, _ columnIndices: [Int]) -> Matrix {
        if rowStart > rowEnd || rowStart < 0 || rowEnd >= self.rows || columnIndices.max()! >= self.columns || columnIndices.min()! < 0 {
            preconditionFailure("Invalid submatrix indices")
        }
        return Matrix(rows: rowEnd - rowStart + 1, columns: columnIndices.count) { i, j in
            return self[rowStart + i, columnIndices[j]]
        }
    }

    public func add(_ matrix: Matrix) -> Matrix {
        if !self.hasSameDimensions(matrix) {
            preconditionFailure("Matrices must have the same dimensions")
        }
        return self.map { i, j, value in
            return value + matrix[i, j]
        }
    }

    public static func +(lhs: Matrix, rhs: Matrix) -> Matrix {
        return lhs.add(rhs)
    }

    public func add(_ scalar: Double) -> Matrix {
        return self.map { $0 + scalar }
    }

    public static func +(lhs: Matrix, rhs: Double) -> Matrix {
        return lhs.add(rhs)
    }

    public func subtract(_ matrix: Matrix) -> Matrix {
        if !self.hasSameDimensions(matrix) {
            preconditionFailure("Matrices must have the same dimensions")
        }
        return self.map { i, j, value in
            return value - matrix[i, j]
        }
    }

    public static func -(lhs: Matrix, rhs: Matrix) -> Matrix {
        return lhs.subtract(rhs)
    }

    public func subtract(_ scalar: Double) -> Matrix {
        return self.map { $0 - scalar }
    }

    public static func -(lhs: Matrix, rhs: Double) -> Matrix {
        return lhs.subtract(rhs)
    }

    public func multiply(_ matrix: Matrix) -> Matrix {
        if self.columns != matrix.rows {
            preconditionFailure("Matrices must have compatible dimensions")
        }
        return Matrix(rows: rows, columns: matrix.columns) { i, j in
            var sum = 0.0
            for k in 0..<self.columns {
                sum += self[i, k] * matrix[k, j]
            }
            return sum
        }
    }

    public static func *(lhs: Matrix, rhs: Matrix) -> Matrix {
        return lhs.multiply(rhs)
    }

    public func multiply(_ scalar: Double) -> Matrix {
        return self.map { $0 * scalar }
    }

    public static func *(lhs: Matrix, rhs: Double) -> Matrix {
        return lhs.multiply(rhs)
    }

    public static func *(lhs: Double, rhs: Matrix) -> Matrix {
        return rhs.multiply(lhs)
    }

    public func multiply (_ vector: Vector) -> Vector {
        if self.columns != vector.count {
            preconditionFailure("Matrix and vector must have compatible dimensions")
        }
        let output = Vector(count: self.rows, repeatedValue: 0)
        for i in 0..<self.rows {
            for j in 0..<self.columns {
                output[i] += self[i, j] * vector[j]
            }
        }
        return output
    }

    public static func *(lhs: Matrix, rhs: Vector) -> Vector {
        return lhs.multiply(rhs)
    }

    public func divide(_ matrix: Matrix) -> Matrix {
        if !self.hasSameDimensions(matrix) {
            preconditionFailure("Matrices must have the same dimensions")
        }
        return self.map { i, j, value in
            return value / matrix[i, j]
        }
    }

    public static func /(lhs: Matrix, rhs: Matrix) -> Matrix {
        return lhs.divide(rhs)
    }

    public func divide(_ scalar: Double) -> Matrix {
        return self.map { $0 / scalar }
    }

    public static func /(lhs: Matrix, rhs: Double) -> Matrix {
        return lhs.divide(rhs)
    }

    public func power(_ exponent: Matrix) -> Matrix {
        if !self.hasSameDimensions(exponent) {
            preconditionFailure("Matrices must have the same dimensions")
        }
        let output = self
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
        return lhs.power(rhs)
    }

    public func root(_ root: Matrix) -> Matrix {
        if !self.hasSameDimensions(root) {
            preconditionFailure("Matrices must have the same dimensions")
        }
        let output = self
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

    public func sqrt() -> Matrix {
        return self.map { pow($0, 1 / 2) }
    }

    public static prefix func %(matrix: Matrix) -> Matrix {
        return matrix.sqrt()
    }

    public func root(_ root: Double) -> Matrix {
        return self.map { pow($0, 1 / root) }
    }

    public static func %(lhs: Matrix, rhs: Double) -> Matrix {
        return lhs.root(rhs)
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
        guard self.columns == matrix.rows else {
            preconditionFailure("Matrices must have compatible dimensions")
        }
        let result = Matrix(rows: self.rows, columns: matrix.columns, repeatedValue: 0)
        for i in 0..<self.rows {
            for j in 0..<matrix.columns {
                for k in 0..<self.columns {
                    result[i, j] += self[i, k] * matrix[k, j]
                }
            }
        }
        
        return result
    }

    public static prefix func *(matrix: Matrix) -> Matrix {
        return matrix.dot(matrix)
    }

    public static func determinant(_ matrix: Matrix) -> Double {
        if !matrix.isSquare() {
            preconditionFailure("Matrix must be square")
        }
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
        if !matrix.isSquare() {
            preconditionFailure("Matrix must be square")
        }
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
        if !self.isSquare() {
            preconditionFailure("Matrix must be square")
        }
        let determinant = |self
        if determinant == 0 {
            preconditionFailure("Matrix must be invertible")
        }
        return Matrix.adjugate(self) / determinant
    }

    public func pseudoInverse() -> Matrix {
        return (~self * self).inverse() * ~self
    }

    public func regularizedPseudoInverse() -> Matrix {
        return (~self * self + self.identity.inverse() * ~self).inverse() * ~self
    }

    public func autoInverse() -> Matrix {
        if self.invertible {
            return self.inverse()
        } else {
            return self.pseudoInverse()
        }
    }

    public static prefix func !(matrix: Matrix) -> Matrix {
        return matrix.autoInverse()
    }

    public static prefix func -(matrix: Matrix) -> Matrix {
        return matrix.map { -$0 }
    }

    public func insertColumn(_ column: [Double], at index: Int) -> Matrix {
        guard column.count == rows else {
            preconditionFailure("Column must have the same number of rows as the matrix")
        }
        var elements = [Double]()
        for i in 0..<rows {
            for j in 0..<columns {
                if j == index {
                    elements.append(column[i])
                }
                elements.append(self[i, j])
            }
        }
        return Matrix(rows: rows, columns: columns + 1, elements: elements)
    }

    public func insertRow(_ row: [Double], at index: Int) -> Matrix {
        guard row.count == columns else {
            preconditionFailure("Row must have the same number of columns as the matrix")
        }
        var elements = [Double]()
        for i in 0..<rows {
            for j in 0..<columns {
                if i == index {
                    elements.append(row[j])
                }
                elements.append(self[i, j])
            }
        }
        return Matrix(rows: rows + 1, columns: columns, elements: elements)
    }

    public func insertColumn(_ value: Double, at index: Int) -> Matrix {
        var elements = [Double]()
        for i in 0..<rows {
            for j in 0..<columns {
                if j == index {
                    elements.append(value)
                }
                elements.append(self[i, j])
            }
        }
        return Matrix(rows: rows, columns: columns + 1, elements: elements)
    }

    public func insertRow(_ value: Double, at index: Int) -> Matrix {
        var elements = [Double]()
        for i in 0..<rows {
            for j in 0..<columns {
                if i == index {
                    elements.append(value)
                }
                elements.append(self[i, j])
            }
        }
        return Matrix(rows: rows + 1, columns: columns, elements: elements)
    }

    public func removeColumn(at index: Int) -> Matrix {
        var elements = [Double]()
        for i in 0..<rows {
            for j in 0..<columns {
                if j != index {
                    elements.append(self[i, j])
                }
            }
        }
        return Matrix(rows: rows, columns: columns - 1, elements: elements)
    }

    public func removeRow(at index: Int) -> Matrix {
        var elements = [Double]()
        for i in 0..<rows {
            for j in 0..<columns {
                if i != index {
                    elements.append(self[i, j])
                }
            }
        }
        return Matrix(rows: rows - 1, columns: columns, elements: elements)
    }

    public func apply(_ function: (Double) -> Double) -> Matrix {
        return self.map(function)
    }
    
}

