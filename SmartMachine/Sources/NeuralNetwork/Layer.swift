//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation
import Surge

public struct Layer: Codable, Equatable {
    public let size: Int
    public let activation: Activation

    public var weights: Matrix<Double> = Matrix()
    public var biases: [Double] = []

    public init(size: Int, activation: Activation = .none) {
        self.size = size
        self.activation = activation
    }

    public mutating func initialize(
        with previous: Layer,
        weightInitializer: GeneInitializer,
        biasInitializer: GeneInitializer
    ) {
        weights = Matrix(rows: previous.size, columns: size, initializer: weightInitializer)
        biases = (0 ..< size).map(biasInitializer.value(at:))
    }

    public func forward(_ matrix: Matrix<Double>) -> Matrix<Double> {
        guard activation != .none else {
            return matrix
        }

        let weighted = matrix * weights
        let biased = weighted + Matrix(rows: matrix.rows, columns: biases)
        let activated = activation.forward(biased)
        return activated
    }
}

public extension Layer {
    static func input(size: Int) -> Layer {
        return Layer(size: size, activation: .none)
    }

    static func fullyConnected(size: Int, activation: Activation) -> Layer {
        return Layer(size: size, activation: activation)
    }
}
