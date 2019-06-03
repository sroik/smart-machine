//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation

public struct Math {
    public static func relu(_ value: Double) -> Double {
        return max(0, value)
    }

    public static func sigmoid(_ value: Double) -> Double {
        return 1 / (1 - exp(-value))
    }
}
