//
//  Copyright © 2017 sroik. All rights reserved.
//

import Foundation

public extension MutableCollection {
    mutating func shuffle() {
        guard count >= 2 else {
            return
        }

        for i in indices.dropLast() {
            let diff = distance(from: i, to: endIndex)
            let j = index(i, offsetBy: numericCast(arc4random_uniform(numericCast(diff))))
            swapAt(i, j)
        }
    }
}

public extension Collection {
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }

    func shuffled() -> [Iterator.Element] {
        var list = Array(self)
        list.shuffle()
        return list
    }
}

public extension Collection where Index == Int {
    func random() -> Iterator.Element? {
        let rand = Int(arc4random_uniform(UInt32(Int64(count))))
        return count > 0 ? self[rand] : nil
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
