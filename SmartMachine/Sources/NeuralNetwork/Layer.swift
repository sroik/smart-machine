//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation
import Surge

public struct Layer {
    public let size: Int
    public let activation: Activation

    public var weights: Matrix<Double> = Matrix()
    public var bias: Matrix<Double> = Matrix()

    public init(size: Int, activation: Activation = .none) {
        self.size = size
        self.activation = activation
    }

    public mutating func initialize(
        with previous: Layer,
        weightInitializer: GeneInitializer,
        biasInitializer: GeneInitializer
    ) {
        weights = Matrix(rows: size, columns: previous.size, initializer: weightInitializer)
        bias = Matrix(rows: size, columns: previous.size, initializer: biasInitializer)
    }

    public func forward(_ matrix: Matrix<Double>) -> Matrix<Double> {
        guard activation != .none else {
            return matrix
        }

        let weighted = weights * matrix + bias
        let activated = activation.forward(weighted)
        return activated
    }
}
