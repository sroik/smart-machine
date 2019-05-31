//
//  Copyright © 2019 sroik. All rights reserved.
//

import SmartMachine
import Surge
import XCTest

class NeuralNetworkTests: XCTestCase {
    func testEmptyNetCompilation() {
        NeuralNetwork().compile()
    }

    func testXORModel() {
        let input = Matrix([
            [0, 0],
            [0, 1],
            [1, 0],
            [1, 1]
        ])

        let prediction = NeuralNetwork.xor().predict(input)
        XCTAssert(prediction[0, 0] < 0)
        XCTAssert(prediction[1, 0] > 0)
        XCTAssert(prediction[2, 0] > 0)
        XCTAssert(prediction[3, 0] < 0)
    }
}

private extension NeuralNetwork {
    static func xor() -> NeuralNetwork {
        let nn = NeuralNetwork()
        nn.add(layer: .input(size: 2))
        nn.add(layer: .fullyConnected(size: 2, activation: .tanh))
        nn.add(layer: .fullyConnected(size: 1, activation: .tanh))

        nn.layers[1].weights = Matrix([[4, -3], [4, -3]])
        nn.layers[1].biases = [-2, 5]
        nn.layers[2].weights = Matrix([[5], [5]])
        nn.layers[2].biases = [-5]
        return nn
    }
}
