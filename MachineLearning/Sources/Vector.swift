//
//  Copyright © 2017 sroik. All rights reserved.
//

import Foundation

protocol Spatial {
    func distance(to: Self) -> Double
}

protocol VectorType: Hashable, Spatial {

    static func + (lhs: Self, rhs: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: Double) -> Self

    /* Identity value such that x + identity = x. Typically the (0, 0, ..., 0) vector. */
    static var identity: Self { get }
}

extension VectorType {
    static func / (lhs: Self, rhs: Double) -> Self {
        guard rhs != 0 else {
            assertionFailure("division by zero!")
            return lhs
        }

        return lhs * (1 / rhs)
    }
}

extension Array where Element: Any & Spatial {
    func nearest(to vector: Element) -> Element? {
        guard let idx = nearestIndex(to: vector) else {
            return nil
        }

        return self[idx]
    }

    func nearestIndex(to vector: Element) -> Int? {
        guard count > 0 else {
            return nil
        }

        var nearestIdx = 0
        var nearestDistance = Double.greatestFiniteMagnitude
        enumerated().forEach { idx, v in
            let distance = vector.distance(to: v)
            if distance < nearestDistance {
                nearestDistance = distance
                nearestIdx = idx
            }
        }

        return nearestIdx
    }
}
