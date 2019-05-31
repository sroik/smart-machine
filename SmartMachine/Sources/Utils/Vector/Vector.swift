//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation
import Surge

public protocol Spatial {
    func distance(to: Self) -> Double
}

public protocol Vector: Spatial, Codable, Hashable {
    typealias Raw = [Double]
    var raw: Raw { get }
    init(raw: Raw)
}

public extension Vector {
    typealias Dimension = Int

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.raw == rhs.raw
    }

    static func + (lhs: Self, rhs: Self) -> Self {
        return Self(raw: add(lhs.raw, rhs.raw))
    }

    static func * (lhs: Self, rhs: Double) -> Self {
        return Self(raw: mul(lhs.raw, Array(repeating: rhs, count: lhs.dimension)))
    }

    static func / (lhs: Self, rhs: Double) -> Self {
        guard rhs != 0 else {
            assertionFailure("division by zero!")
            return lhs
        }

        return lhs * (1 / rhs)
    }

    static func identity(dimension: Dimension) -> Self {
        return Self(value: 0, dimension: dimension)
    }

    var dimension: Dimension {
        return raw.count
    }

    init(value: Double = 0, dimension: Dimension) {
        self.init(raw: Raw(repeating: value, count: dimension))
    }

    func distance(to: Self) -> Double {
        return sqrt(sum(pow(sub(raw, to.raw), 2)))
    }
}

extension Array where Element == Double {
    var raw: Vector.Raw {
        return self
    }

    init(raw: Vector.Raw) {
        self.init(raw)
    }
}
