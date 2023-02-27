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

}