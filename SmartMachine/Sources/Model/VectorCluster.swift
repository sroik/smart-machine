//
//  Copyright © 2017 sroik. All rights reserved.
//

import Foundation

public struct VectorCluster<V: VectorType> {
    public var vectors: [V]
    public var centroid: V

    public init(vectors: [V], centroid: V = .identity) {
        self.vectors = vectors
        self.centroid = centroid
    }
}

public extension VectorCluster {
    static var identity: VectorCluster {
        return VectorCluster(vectors: [], centroid: V.identity)
    }

    func adjustingCentroid() -> VectorCluster {
        let centroid = vectors.reduce(.identity) { $0 + $1 / Double(vectors.count) }
        return VectorCluster(vectors: vectors, centroid: centroid)
    }

    func convergeDistance() -> Double {
        return vectors.reduce(0) { $0 + $1.distance(to: centroid) }
    }
}
