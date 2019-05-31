//
//  Copyright © 2019 sroik. All rights reserved.
//

import Accelerate
import Foundation

public extension Collection {
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension Array where Element: Any & Spatial {
    func nearest(to vector: Element) -> Element? {
        guard let idx = indexOfNearest(to: vector) else {
            return nil
        }

        return self[idx]
    }

    func indexOfNearest(to vector: Element) -> Int? {
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
