//
//  Copyright © 2019 sroik. All rights reserved.
//

import SmartMachine
import XCTest

class SmartMachineTests: XCTestCase {
    func testSimple2DClustering() {
        let points = [
            Point(0.5, 0.5), Point(1, 1), Point(1, 1.5), Point(1.5, 1),
            Point(5, 5), Point(4, 5), Point(5, 4), Point(4, 4),
            Point(9, 9), Point(9, 10), Point(10, 9), Point(10, 10)
        ]

        let clusterer = KMeansClusterer(dataset: points)
        let clusters = clusterer.fit(k: 3)
        let centroids = clusters.map { $0.centroid }

        XCTAssertEqual(centroids.count, 3)
        XCTAssertTrue(centroids.contains(Point(1, 1)))
        XCTAssertTrue(centroids.contains(Point(4.5, 4.5)))
        XCTAssertTrue(centroids.contains(Point(9.5, 9.5)))
    }
}
