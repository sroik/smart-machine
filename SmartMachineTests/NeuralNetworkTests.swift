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
        let nn = NeuralNetwork()
        nn.add(layer: .input(size: 2))
        nn.add(layer: .fullyConnected(size: 2, activation: .tanh))
        nn.add(layer: .fullyConnected(size: 1, activation: .tanh))

        nn.layers[1].weights = Matrix([[4, -3], [4, -3]])
        nn.layers[1].biases = [-2, 5]
        nn.layers[2].weights = Matrix([[5], [5]])
        nn.layers[2].biases = [-5]

        let zeroOne = nn.predict(Matrix([[0, 1]]))
        let oneZero = nn.predict(Matrix([[1, 0]]))
        let oneOne = nn.predict(Matrix([[0, 1]]))
        let zeroZero = nn.predict(Matrix([[0, 0]]))

        XCTAssert(zeroZero[0, 0] < 0)
        XCTAssert(oneZero[0, 0] > 0)
        XCTAssert(zeroOne[0, 0] > 0)
        XCTAssert(oneOne[0, 0] > 0)
    }
}
