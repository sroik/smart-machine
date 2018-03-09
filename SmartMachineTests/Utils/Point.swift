//
//  Copyright © 2017 sroik. All rights reserved.
//

import Foundation
import SmartMachine

struct Point {
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

extension Point: Hashable {
    var hashValue: Int {
        return x.hashValue ^ y.hashValue &* 16_777_619
    }

    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
