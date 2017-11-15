//
//  Copyright © 2017 sroik. All rights reserved.
//

import Foundation

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

extension Point: VectorType {
    static func -(lhs: Point, rhs: Point) -> Point {
        return Point(lhs.x - rhs.x, lhs.y - rhs.y)
    }
    
    static func +(lhs: Point, rhs: Point) -> Point {
        return Point(lhs.x + rhs.x, lhs.y + rhs.y)
    }
    
    static func *(lhs: Point, rhs: Double) -> Point {
        return Point(lhs.x * rhs, lhs.y * rhs)
    }
    
    static var identity: Point {
        return Point(0, 0)
    }
    
    var hashValue: Int {
        return x.hashValue ^ y.hashValue &* 16_777_619
    }
    
    func distance(to: Point) -> Double {
        return sqrt(pow(x - to.x, 2) + pow(y - to.y, 2))
    }
    
    static func ==(lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
