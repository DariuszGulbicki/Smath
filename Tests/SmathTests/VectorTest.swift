import XCTest
import Smath

final class VectorTest: XCTestCase {

    func testVectorCreation() {
        // With elements
        let vector = Vector(elements: [1, 2, 3, 4, 5])
        XCTAssertEqual(vector.elements, [1, 2, 3, 4, 5])
        // With repeating value
        let vector2 = Vector(count: 5, repeatedValue: 1)
        XCTAssertEqual(vector2.elements, [1, 1, 1, 1, 1])
        // With array literal
        let vector3: Vector = [1, 2, 3, 4, 5]
        XCTAssertEqual(vector3.elements, [1, 2, 3, 4, 5])
    }

    func testVectorCount() {
        let vector = Vector(elements: [1, 2, 3, 4, 5])
        XCTAssertEqual(vector.count, 5)
    }
    
    func testVectorSubscript() {
        let vector = Vector(elements: [1, 2, 3, 4, 5])
        XCTAssertEqual(vector[0], 1)
        XCTAssertEqual(vector[1], 2)
        XCTAssertEqual(vector[2], 3)
        XCTAssertEqual(vector[3], 4)
        XCTAssertEqual(vector[4], 5)
    }

    func testVectorAddition() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = Vector(elements: [1, 2, 3, 4, 5])
        let vector3 = vector1.add(vector2)
        XCTAssertEqual(vector3.elements, [2, 4, 6, 8, 10])
    }

    func testVectorAdditionWithScalar() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = vector1.add(1)
        XCTAssertEqual(vector2.elements, [2, 3, 4, 5, 6])
    }

    func testVectorAdditionOperator() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = Vector(elements: [1, 2, 3, 4, 5])
        let vector3 = vector1 + vector2
        XCTAssertEqual(vector3.elements, [2, 4, 6, 8, 10])
    }

    func testVectorAdditionWithScalarOperator() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = vector1 + 1
        XCTAssertEqual(vector2.elements, [2, 3, 4, 5, 6])
    }

    func testVectorSubtraction() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = Vector(elements: [1, 2, 3, 4, 5])
        let vector3 = vector1.subtract(vector2)
        XCTAssertEqual(vector3.elements, [0, 0, 0, 0, 0])
    }

    func testVectorSubtractionWithScalar() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = vector1.subtract(1)
        XCTAssertEqual(vector2.elements, [0, 1, 2, 3, 4])
    }

    func testVectorSubtractionOperator() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = Vector(elements: [1, 2, 3, 4, 5])
        let vector3 = vector1 - vector2
        XCTAssertEqual(vector3.elements, [0, 0, 0, 0, 0])
    }

    func testVectorSubtractionWithScalarOperator() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = vector1 - 1
        XCTAssertEqual(vector2.elements, [0, 1, 2, 3, 4])
    }

    func testVectorMultiplication() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = Vector(elements: [1, 2, 3, 4, 5])
        let vector3 = vector1.multiply(vector2)
        XCTAssertEqual(vector3.elements, [1, 4, 9, 16, 25])
    }

    func testVectorMultiplicationWithScalar() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = vector1.multiply(2)
        XCTAssertEqual(vector2.elements, [2, 4, 6, 8, 10])
    }

    func testVectorMultiplicationOperator() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = Vector(elements: [1, 2, 3, 4, 5])
        let vector3 = vector1 * vector2
        XCTAssertEqual(vector3.elements, [1, 4, 9, 16, 25])
    }

    func testVectorMultiplicationWithScalarOperator() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = vector1 * 2
        XCTAssertEqual(vector2.elements, [2, 4, 6, 8, 10])
    }

    func testVectorDivision() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = Vector(elements: [1, 2, 3, 4, 5])
        let vector3 = vector1.divide(vector2)
        XCTAssertEqual(vector3.elements, [1, 1, 1, 1, 1])
    }

    func testVectorDivisionWithScalar() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = vector1.divide(2)
        XCTAssertEqual(vector2.elements, [0.5, 1, 1.5, 2, 2.5])
    }

    func testVectorDivisionOperator() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = Vector(elements: [1, 2, 3, 4, 5])
        let vector3 = vector1 / vector2
        XCTAssertEqual(vector3.elements, [1, 1, 1, 1, 1])
    }

    func testVectorDivisionWithScalarOperator() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = vector1 / 2
        XCTAssertEqual(vector2.elements, [0.5, 1, 1.5, 2, 2.5])
    }

    func testVectorPower() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = Vector(elements: [2, 2, 2, 2, 2])
        let vector3 = vector1.power(vector2)
        XCTAssertEqual(vector3.elements, [1, 4, 9, 16, 25])
    }

    func testVectorPowerWithScalar() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = vector1.power(2)
        XCTAssertEqual(vector2.elements, [1, 4, 9, 16, 25])
    }

    func testVectorPowerOperator() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = Vector(elements: [2, 2, 2, 2, 2])
        let vector3 = vector1 ^ vector2
        XCTAssertEqual(vector3.elements, [1, 4, 9, 16, 25])
    }

    func testVectorPowerWithScalarOperator() {
        let vector1 = Vector(elements: [1, 2, 3, 4, 5])
        let vector2 = vector1 ^ 2
        XCTAssertEqual(vector2.elements, [1, 4, 9, 16, 25])
    }

    func testVectorRoot() {
        let vector1 = Vector(elements: [1, 4, 9, 16, 25])
        let vector2 = Vector(elements: [2, 2, 2, 2, 2])
        let vector3 = vector1.root(vector2)
        XCTAssertEqual(vector3.elements, [1, 2, 3, 4, 5])
    }

    func testVectorRootWithScalar() {
        let vector1 = Vector(elements: [1, 4, 9, 16, 25])
        let vector2 = vector1.root(2)
        XCTAssertEqual(vector2.elements, [1, 2, 3, 4, 5])
    }

    func testVectorRootOperator() {
        let vector1 = Vector(elements: [1, 4, 9, 16, 25])
        let vector2 = Vector(elements: [2, 2, 2, 2, 2])
        let vector3 = vector1 % vector2
        XCTAssertEqual(vector3.elements, [1, 2, 3, 4, 5])
    }

    func testVectorRootWithScalarOperator() {
        let vector1 = Vector(elements: [1, 4, 9, 16, 25])
        let vector2 = vector1 % 2
        XCTAssertEqual(vector2.elements, [1, 2, 3, 4, 5])
    }

    func testVectorSquareRoot() {
        let vector1 = Vector(elements: [1, 4, 9, 16, 25])
        let vector2 = vector1.squareRoot()
        XCTAssertEqual(vector2.elements, [1, 2, 3, 4, 5])
    }

    func testVectorSquareRootOperator() {
        let vector1 = Vector(elements: [1, 4, 9, 16, 25])
        let vector2 = %vector1
        XCTAssertEqual(vector2.elements, [1, 2, 3, 4, 5])
    }

}