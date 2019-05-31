//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation
import SmartMachine

struct Point: Hashable {
    let x: Double
    let y: Double

    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }

    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

extension Point: Vector {
    var raw: Vector.Raw {
        return [x, y]
    }

    init(raw: Vector.Raw) {
        self.x = raw[0]
        self.y = raw[1]
    }
}
