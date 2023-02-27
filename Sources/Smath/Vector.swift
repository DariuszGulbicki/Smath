public class Vector: ExpressibleByArrayLiteral {

    public var elements: [Double]

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

    public var count: Int {
        return elements.count
    }

}