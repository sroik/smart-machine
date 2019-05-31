//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation
import Surge

public enum Activation {
    case none
    case relu
    case sigmoid

    public func forward(_ matrix: Matrix<Double>) -> Matrix<Double> {
        switch self {
        case .none:
            let e = matrix.map { exp($0) }
            return e / (e.repeating(value: 1) + e)
        case .relu:
            return matrix.map { max(0, $0) }
        case .sigmoid:
            return matrix
        }
    }
}
