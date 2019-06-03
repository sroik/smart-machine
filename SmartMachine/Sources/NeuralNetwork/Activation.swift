//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation
import Surge

public enum Activation: String, Codable, Hashable {
    case none
    case relu
    case sigmoid
    case tanh
    case softmax

    public func forward(_ matrix: Matrix<Double>) -> Matrix<Double> {
        switch self {
        case .none:
            return matrix
        case .relu:
            return matrix.map { Math.relu($0) }
        case .sigmoid:
            return matrix.map { Math.sigmoid($0) }
        case .tanh:
            return matrix.map { Foundation.tanh($0) }
        case .softmax:
            let exps = matrix.map { exp($0) }
            let sum = exps.sum()
            return exps.map { $0 / sum }
        }
    }
}
