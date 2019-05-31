//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation

public enum GeneInitializer {
    case random
    case zeros

    public func value(at index: Int) -> Double {
        switch self {
        case .random:
            return Double.random(in: 0 ... 1)
        case .zeros:
            return 0
        }
    }
}
