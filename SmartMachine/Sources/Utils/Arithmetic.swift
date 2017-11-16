//
//  Copyright © 2017 sroik. All rights reserved.
//

import UIKit
import Accelerate

public func sum(_ x: [Double]) -> Double {
    var result: Double = 0
    let count = x.count
    x.withUnsafeBufferPointer { x in
        if let ba = x.baseAddress {
            withUnsafeMutablePointer(to: &result) { pointer in
                vDSP_sveD(ba, 1, pointer, vDSP_Length(count))
            }
        }
    }
    return result
}

public func sumsq(_ x: [Double]) -> Double {
    var result: Double = 0
    let count = x.count
    x.withUnsafeBufferPointer { x in
        if let ba = x.baseAddress {
            withUnsafeMutablePointer(to: &result) { pointer in
                vDSP_svesqD(ba, 1, pointer, vDSP_Length(count))
            }
        }
    }
    return result
}

public extension Double {
    static var random: Double {
        return Double(arc4random()) / Double(UInt32.max)
    }

    static func random(min: Double = 0.0, max: Double = 1.0) -> Double {
        return Double.random * (max - min) + min
    }
}
