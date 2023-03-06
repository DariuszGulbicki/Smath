// Matrix test
import XCTest
import Smath

class MatrixTest: XCTestCase {

    func testMatrixCreation() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        XCTAssertEqual(matrix[0, 0], 1)
        XCTAssertEqual(matrix[0, 1], 2)
        XCTAssertEqual(matrix[1, 0], 3)
        XCTAssertEqual(matrix[1, 1], 4)
    }
    
    func testMatrixMap() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let mappedMatrix = matrix.map { $0 * 2 }
        XCTAssertEqual(mappedMatrix[0, 0], 2)
        XCTAssertEqual(mappedMatrix[0, 1], 4)
        XCTAssertEqual(mappedMatrix[1, 0], 6)
        XCTAssertEqual(mappedMatrix[1, 1], 8)
    }

    func testMatrixAdd() {
        let matrix1 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let matrix2 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        //let matrix3 = Matrix(rows: 3, columns: 2, elements: [1, 2, 3, 4, 5, 6])
        let addedMatrix = matrix1.add(matrix2)
        XCTAssertEqual(addedMatrix[0, 0], 2)
        XCTAssertEqual(addedMatrix[0, 1], 4)
        XCTAssertEqual(addedMatrix[1, 0], 6)
        XCTAssertEqual(addedMatrix[1, 1], 8)
    }
    
    func testMatrixAddOperator() {
        let matrix1 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let matrix2 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let addedMatrix = matrix1 + matrix2
        XCTAssertEqual(addedMatrix[0, 0], 2)
        XCTAssertEqual(addedMatrix[0, 1], 4)
        XCTAssertEqual(addedMatrix[1, 0], 6)
        XCTAssertEqual(addedMatrix[1, 1], 8)
    }

    func testMatrixAddScalar() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let addedMatrix = matrix.add(2)
        XCTAssertEqual(addedMatrix[0, 0], 3)
        XCTAssertEqual(addedMatrix[0, 1], 4)
        XCTAssertEqual(addedMatrix[1, 0], 5)
        XCTAssertEqual(addedMatrix[1, 1], 6)
    }

    func testMatrixAddScalarOperator() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let addedMatrix = matrix + 2
        XCTAssertEqual(addedMatrix[0, 0], 3)
        XCTAssertEqual(addedMatrix[0, 1], 4)
        XCTAssertEqual(addedMatrix[1, 0], 5)
        XCTAssertEqual(addedMatrix[1, 1], 6)
    }

    func testMatrixSubtract() {
        let matrix1 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let matrix2 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let subtractedMatrix = matrix1.subtract(matrix2)
        XCTAssertEqual(subtractedMatrix[0, 0], 0)
        XCTAssertEqual(subtractedMatrix[0, 1], 0)
        XCTAssertEqual(subtractedMatrix[1, 0], 0)
        XCTAssertEqual(subtractedMatrix[1, 1], 0)
    }

    func testMatrixSubtractOperator() {
        let matrix1 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let matrix2 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let subtractedMatrix = matrix1 - matrix2
        XCTAssertEqual(subtractedMatrix[0, 0], 0)
        XCTAssertEqual(subtractedMatrix[0, 1], 0)
        XCTAssertEqual(subtractedMatrix[1, 0], 0)
        XCTAssertEqual(subtractedMatrix[1, 1], 0)
    }

    func testMatrixSubtractScalar() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let subtractedMatrix = matrix.subtract(2)
        XCTAssertEqual(subtractedMatrix[0, 0], -1)
        XCTAssertEqual(subtractedMatrix[0, 1], 0)
        XCTAssertEqual(subtractedMatrix[1, 0], 1)
        XCTAssertEqual(subtractedMatrix[1, 1], 2)
    }

    func testMatrixSubtractScalarOperator() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let subtractedMatrix = matrix - 2
        XCTAssertEqual(subtractedMatrix[0, 0], -1)
        XCTAssertEqual(subtractedMatrix[0, 1], 0)
        XCTAssertEqual(subtractedMatrix[1, 0], 1)
        XCTAssertEqual(subtractedMatrix[1, 1], 2)
    }

    func testMatrixMultiply() {
        let matrix1 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let matrix2 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let multipliedMatrix = matrix1.multiply(matrix2)
        XCTAssertEqual(multipliedMatrix[0, 0], 7)
        XCTAssertEqual(multipliedMatrix[0, 1], 10)
        XCTAssertEqual(multipliedMatrix[1, 0], 15)
        XCTAssertEqual(multipliedMatrix[1, 1], 22)
    }

    func testMatrixMultiplyOperator() {
        let matrix1 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let matrix2 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let multipliedMatrix = matrix1 * matrix2
        XCTAssertEqual(multipliedMatrix[0, 0], 7)
        XCTAssertEqual(multipliedMatrix[0, 1], 10)
        XCTAssertEqual(multipliedMatrix[1, 0], 15)
        XCTAssertEqual(multipliedMatrix[1, 1], 22)
    }

    func testMatrixMultiplyScalar() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let multipliedMatrix = matrix.multiply(2)
        XCTAssertEqual(multipliedMatrix[0, 0], 2)
        XCTAssertEqual(multipliedMatrix[0, 1], 4)
        XCTAssertEqual(multipliedMatrix[1, 0], 6)
        XCTAssertEqual(multipliedMatrix[1, 1], 8)
    }

    func testMatrixMultiplyScalarOperator() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let multipliedMatrix = matrix * 2
        XCTAssertEqual(multipliedMatrix[0, 0], 2)
        XCTAssertEqual(multipliedMatrix[0, 1], 4)
        XCTAssertEqual(multipliedMatrix[1, 0], 6)
        XCTAssertEqual(multipliedMatrix[1, 1], 8)
    }

    func testMatrixMultiplyVector() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let vector = Vector(elements: [1, 2])
        let multipliedVector = matrix.multiply(vector)
        XCTAssertEqual(multipliedVector[0], 5)
        XCTAssertEqual(multipliedVector[1], 11)
    }

    func testMatrixDivide() {
        let matrix1 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let matrix2 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let dividedMatrix = matrix1.divide(matrix2)
        XCTAssertEqual(dividedMatrix[0, 0], 1)
        XCTAssertEqual(dividedMatrix[0, 1], 1)
        XCTAssertEqual(dividedMatrix[1, 0], 1)
        XCTAssertEqual(dividedMatrix[1, 1], 1)
    }

    func testMatrixDivideOperator() {
        let matrix1 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let matrix2 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let dividedMatrix = matrix1 / matrix2
        XCTAssertEqual(dividedMatrix[0, 0], 1)
        XCTAssertEqual(dividedMatrix[0, 1], 1)
        XCTAssertEqual(dividedMatrix[1, 0], 1)
        XCTAssertEqual(dividedMatrix[1, 1], 1)
    }

    func testMatrixDivideScalar() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let dividedMatrix = matrix.divide(2)
        XCTAssertEqual(dividedMatrix[0, 0], 0.5)
        XCTAssertEqual(dividedMatrix[0, 1], 1)
        XCTAssertEqual(dividedMatrix[1, 0], 1.5)
        XCTAssertEqual(dividedMatrix[1, 1], 2)
    }

    func testMatrixDivideScalarOperator() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let dividedMatrix = matrix / 2
        XCTAssertEqual(dividedMatrix[0, 0], 0.5)
        XCTAssertEqual(dividedMatrix[0, 1], 1)
        XCTAssertEqual(dividedMatrix[1, 0], 1.5)
        XCTAssertEqual(dividedMatrix[1, 1], 2)
    }

    func testMatrixPower() {
        let matrix1 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let matrix2 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let poweredMatrix = matrix1.power(matrix2)
        XCTAssertEqual(poweredMatrix[0, 0], 1)
        XCTAssertEqual(poweredMatrix[0, 1], 4)
        XCTAssertEqual(poweredMatrix[1, 0], 27)
        XCTAssertEqual(poweredMatrix[1, 1], 256)
    }

    func testMatrixPowerOperator() {
        let matrix1 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let matrix2 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let poweredMatrix = matrix1 ^ matrix2
        XCTAssertEqual(poweredMatrix[0, 0], 1)
        XCTAssertEqual(poweredMatrix[0, 1], 4)
        XCTAssertEqual(poweredMatrix[1, 0], 27)
        XCTAssertEqual(poweredMatrix[1, 1], 256)
    }

    func testMatrixPowerScalar() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let poweredMatrix = matrix.power(2)
        XCTAssertEqual(poweredMatrix[0, 0], 1)
        XCTAssertEqual(poweredMatrix[0, 1], 4)
        XCTAssertEqual(poweredMatrix[1, 0], 9)
        XCTAssertEqual(poweredMatrix[1, 1], 16)
    }

    func testMatrixPowerScalarOperator() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let poweredMatrix = matrix ^ 2
        XCTAssertEqual(poweredMatrix[0, 0], 1)
        XCTAssertEqual(poweredMatrix[0, 1], 4)
        XCTAssertEqual(poweredMatrix[1, 0], 9)
        XCTAssertEqual(poweredMatrix[1, 1], 16)
    }

    func testMatrixRoot() {
        let matrix1 = Matrix(rows: 2, columns: 2, elements: [1, 4, 9, 16])
        let matrix2 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let rootedMatrix = matrix1.root(matrix2)
        XCTAssertEqual(rootedMatrix[0, 0].rounded(), 1)
        XCTAssertEqual(rootedMatrix[0, 1].rounded(), 2)
        XCTAssertEqual(rootedMatrix[1, 0].rounded(), 2)
        XCTAssertEqual(rootedMatrix[1, 1].rounded(), 2)
    }

    func testMatrixRootOperator() {
        let matrix1 = Matrix(rows: 2, columns: 2, elements: [1, 4, 9, 16])
        let matrix2 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let rootedMatrix = matrix1 % matrix2
        XCTAssertEqual(rootedMatrix[0, 0].rounded(), 1)
        XCTAssertEqual(rootedMatrix[0, 1].rounded(), 2)
        XCTAssertEqual(rootedMatrix[1, 0].rounded(), 2)
        XCTAssertEqual(rootedMatrix[1, 1].rounded(), 2)
    }

    func testMatrixRootScalar() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 4, 9, 16])
        let rootedMatrix = matrix.root(2)
        XCTAssertEqual(rootedMatrix[0, 0], 1)
        XCTAssertEqual(rootedMatrix[0, 1], 2)
        XCTAssertEqual(rootedMatrix[1, 0], 3)
        XCTAssertEqual(rootedMatrix[1, 1], 4)
    }

    func testMatrixRootScalarOperator() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 4, 9, 16])
        let rootedMatrix = matrix % 2
        XCTAssertEqual(rootedMatrix[0, 0], 1)
        XCTAssertEqual(rootedMatrix[0, 1], 2)
        XCTAssertEqual(rootedMatrix[1, 0], 3)
        XCTAssertEqual(rootedMatrix[1, 1], 4)
    }

    func testMatrixTranspose() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let transposedMatrix = matrix.transpose()
        XCTAssertEqual(transposedMatrix[0, 0], 1)
        XCTAssertEqual(transposedMatrix[0, 1], 3)
        XCTAssertEqual(transposedMatrix[1, 0], 2)
        XCTAssertEqual(transposedMatrix[1, 1], 4)
    }

    func testMatrixTransposeOperator() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let transposedMatrix = ~matrix
        XCTAssertEqual(transposedMatrix[0, 0], 1)
        XCTAssertEqual(transposedMatrix[0, 1], 3)
        XCTAssertEqual(transposedMatrix[1, 0], 2)
        XCTAssertEqual(transposedMatrix[1, 1], 4)
    }

    func testMatrixDeterminant() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let determinant = Matrix.determinant(matrix)
        XCTAssertEqual(determinant, -2)
    }

    func testMatrixDeterminantOperator() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let determinant = |matrix
        XCTAssertEqual(determinant, -2)
    }

    func testMatrixInverse() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let inverse = matrix.inverse()
        XCTAssertEqual(inverse[0, 0], -2)
        XCTAssertEqual(inverse[0, 1], 1)
        XCTAssertEqual(inverse[1, 0], 1.5)
        XCTAssertEqual(inverse[1, 1], -0.5)
    }

    func testMatrixPseudoInverse() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let inverse = matrix.pseudoInverse()
        XCTAssertEqual(inverse[0, 0], -2)
        XCTAssertEqual(inverse[0, 1], 1)
        XCTAssertEqual(inverse[1, 0], 1.5)
        XCTAssertEqual(inverse[1, 1], -0.5)
    }

    func testMatrixAutoInverse() {
        let matrix = Matrix(rows: 3, columns: 3, elements: [1, 2, 3, 4, 5, 6, 7, 8, 9])
        let inverse = matrix.autoInverse()
        XCTAssertEqual(inverse[0, 0], -2)
        XCTAssertEqual(inverse[0, 1], 1)
        XCTAssertEqual(inverse[1, 0], 1.5)
        XCTAssertEqual(inverse[1, 1], -0.5)
    }

    func testMatrixAutoInverseOperator() {
        let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let inverse = !matrix
        XCTAssertEqual(inverse[0, 0], -2)
        XCTAssertEqual(inverse[0, 1], 1)
        XCTAssertEqual(inverse[1, 0], 1.5)
        XCTAssertEqual(inverse[1, 1], -0.5)
    }

    func testMatrixDot() {
        let matrix1 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let matrix2 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
        let dot = matrix1.dot(matrix2)
        XCTAssertEqual(dot[0, 0], 7)
        XCTAssertEqual(dot[0, 1], 10)
        XCTAssertEqual(dot[1, 0], 15)
        XCTAssertEqual(dot[1, 1], 22)
    }

}