//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation
import Surge

public final class NeuralNetwork {
    public var layers: [Layer]

    public init(layers: [Layer] = []) {
        self.layers = layers
    }

    public func add(layer: Layer) {
        layers.append(layer)
    }

    public func compile(
        weightInitializer: GeneInitializer = .random,
        biasInitializer: GeneInitializer = .zeros
    ) {
        layers.indices.dropFirst().forEach { index in
            layers[index].initialize(
                with: layers[index - 1],
                weightInitializer: weightInitializer,
                biasInitializer: biasInitializer
            )
        }
    }

    public func predict(_ input: Matrix<Double>) -> Matrix<Double> {
        return layers.reduce(input) { output, layer in
            layer.forward(output)
        }
    }
}
