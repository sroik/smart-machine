//
//  Copyright © 2017 sroik. All rights reserved.
//

import UIKit

public extension Double {
    static var random: Double {
        return Double(arc4random()) / Double(UInt32.max)
    }

    static func random(min: Double = 0.0, max: Double = 1.0) -> Double {
        return Double.random * (max - min) + min
    }
}
