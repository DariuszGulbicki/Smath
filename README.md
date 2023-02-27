[![Swift](https://github.com/DariuszGulbicki/Smath/actions/workflows/swift.yml/badge.svg)](https://github.com/DariuszGulbicki/Smath/actions/workflows/swift.yml)

# Smath

**Smath** is a math library written in Swift. Currently, it provides support for matrices, but more features will be added in the future. The library is designed to be easy to use, efficient, and flexible.

## Installation

You can integrate sMath into your project using Swift Package Manager. To add sMath to your project, add the following line to your Package.swift file:

```swift
.package(url: "https://github.com/DariuszGulbicki/smath.git", from: "0.0.1")
```

## Usage

### Creating a matrix

You can create a matrix in sMath using the Matrix class. Here's an example of how to create a matrix:

```swift
let matrix = Matrix(rows: 3, columns: 3, elements: [1, 2, 3, 4, 5, 6, 7, 8, 9])
```

This creates a 3x3 matrix with the elements [1, 2, 3, 4, 5, 6, 7, 8, 9].

### Accessing elements

You can access elements of a matrix using the [row, column]. Here's an example:

```swift
let element = matrix[1, 1]
```

This gets the element in the second row and second column of the matrix (which is 5 in this case).

### Matrix operations

sMath provides many matrix operations, including addition, subtraction, multiplication, and more. Here's an example of how to add two matrices together:

```swift
let matrix1 = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
let matrix2 = Matrix(rows: 2, columns: 2, elements: [5, 6, 7, 8])
let result = matrix1 + matrix2
```

This creates two 2x2 matrices and adds them together to get a new 2x2 matrix

### Transpose

You can also transpose a matrix using the transpose() method. Here's an example:

```swift
let matrix = Matrix(rows: 2, columns: 3, elements: [1, 2, 3, 4, 5, 6])
let transposed = matrix.transpose()
// or
let transposed = ~matrix
```

This transposes a 2x3 matrix into a 3x2 matrix.

### Determinant

You can also calculate the determinant of a matrix using the determinant() method. Here's an example:

```swift
let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
let determinant = matrix.determinant()
// or
let determinant = |matrix
```

This calculates the determinant of a 2x2 matrix.

### Inverse

You can also calculate the inverse of a matrix using the inverse() method. Here's an example:

```swift
let matrix = Matrix(rows: 2, columns: 2, elements: [1, 2, 3, 4])
let inverse = matrix.inverse()
// or
let inverse = !matrix
```

## Contributing

sMath is an open-source project, and we welcome contributions from anyone. If you'd like to contribute, please fork the repository and submit a pull request. If you find a bug or have a feature request, please open an issue.

## License

sMath is released under the MIT license. See LICENSE for details.