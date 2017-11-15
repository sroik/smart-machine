//
//  Copyright © 2017 sroik. All rights reserved.
//

import Foundation

extension MutableCollection {
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

extension Collection {
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    func shuffled() -> [Iterator.Element] {
        var list = Array(self)
        list.shuffle()
        return list
    }
}

extension Collection where Index == Int {
    func random() -> Iterator.Element? {
        let rand = Int(arc4random_uniform(UInt32(Int64(count))))
        return count > 0 ? self[rand] : nil
    }
}
