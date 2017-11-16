//
//  Copyright © 2017 sroik. All rights reserved.
//

import Foundation

public protocol Spatial {
    func distance(to: Self) -> Double
}

public protocol VectorType: Hashable, Spatial {

    static func + (lhs: Self, rhs: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: Double) -> Self

    /* Identity value such that x + identity = x. Typically the (0, 0, ..., 0) vector. */
    static var identity: Self { get }
}

public extension VectorType {
    static func / (lhs: Self, rhs: Double) -> Self {
        guard rhs != 0 else {
            assertionFailure("division by zero!")
            return lhs
        }

        return lhs * (1 / rhs)
    }
}
