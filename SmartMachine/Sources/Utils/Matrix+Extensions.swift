//
//  Copyright © 2019 sroik. All rights reserved.
//

import Surge

public extension Matrix {
    typealias EnumerationBlock = (_ row: Int, _ column: Int, _ element: Scalar) -> Void

    init(rows: Int, columns: Int, grid: [Scalar]) {
        self.init(rows: rows, columns: columns, repeatedValue: 0)

        guard grid.count == rows * columns else {
            assertionFailure("wrong grid size")
            return
        }

        enumerate { row, column, _ in
            let index = row * columns + column
            self[row, column] = grid[index]
        }
    }

    func enumerate(_ block: EnumerationBlock) {
        for r in 0 ..< rows {
            for c in 0 ..< columns {
                block(r, c, self[r, c])
            }
        }
    }

    func map<T>(_ transform: (Scalar) -> T) -> Matrix<T> {
        var matrix = Matrix<T>(rows: rows, columns: columns, repeatedValue: 0)
        enumerate { row, column, element in
            matrix[row, column] = transform(element)
        }
        return matrix
    }

    func repeating(value: Scalar) -> Matrix<Scalar> {
        return Matrix(rows: rows, columns: columns, repeatedValue: value)
    }
}

public extension Matrix where Scalar == Double {
    init() {
        self.init(rows: 0, columns: 0, repeatedValue: 0)
    }

    init(rows: Int, columns: Int, initializer: GeneInitializer) {
        let grid = (0 ..< rows * columns).map(initializer.value(at:))
        self.init(rows: rows, columns: columns, grid: grid)
    }
}
