//
//  Copyright © 2019 sroik. All rights reserved.
//

import Surge

public extension Matrix {
    typealias EnumerationBlock = (_ row: Int, _ column: Int, _ element: Scalar) -> Void

    var values: [Scalar] {
        var buffer: [Scalar] = []
        enumerate { _, _, element in
            buffer.append(element)
        }
        return buffer
    }

    init(rows: Int, columns: [Scalar]) {
        self.init((0 ..< rows).map { _ in columns })
    }

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
        enumerate { matrix[$0, $1] = transform($2) }
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

extension Matrix: Codable where Scalar: Codable {
    enum CodingKeys: String, CodingKey {
        case values
        case rows
        case columns
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let values = try container.decode([Scalar].self, forKey: .values)
        let rows = try container.decode(Int.self, forKey: .values)
        let columns = try container.decode(Int.self, forKey: .values)
        self.init(rows: rows, columns: columns, grid: values)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rows, forKey: .rows)
        try container.encode(columns, forKey: .columns)
        try container.encode(values, forKey: .values)
    }
}
