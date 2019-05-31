//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation
import Surge

public enum Activation {
    case none
    case relu
    case sigmoid
    case tanh

    public func forward(_ matrix: Matrix<Double>) -> Matrix<Double> {
        switch self {
        case .none:
            return matrix
        case .relu, .sigmoid, .tanh:
            return matrix.map(forward)
        }
    }

    public func forward(_ value: Double) -> Double {
        switch self {
        case .none:
            return value
        case .relu:
            return max(0, value)
        case .sigmoid:
            return 1 / (1 - exp(-value))
        case .tanh:
            return Foundation.tanh(value)
        }
    }
}
