//
//  Copyright © 2017 sroik. All rights reserved.
//

import Foundation
import Surge

public struct VectorCluster<V: Vector> {
    public var vectors: [V]
    public var centroid: V

    public var dimension: Vector.Dimension {
        return centroid.dimension
    }

    public init(vectors: [V], centroid: V) {
        self.vectors = vectors
        self.centroid = centroid
    }

    public init(vectors: [V], dimension: Vector.Dimension) {
        self.vectors = vectors
        self.centroid = V.identity(dimension: dimension)
    }
}

public extension VectorCluster {
    static func identity(dimension: Vector.Dimension) -> VectorCluster {
        return VectorCluster(vectors: [], dimension: dimension)
    }

    func adjustingCentroid() -> VectorCluster {
        let sum = vectors.reduce(V.identity(dimension: dimension)) { $0 + $1 }
        let centroid = sum / Double(vectors.count)
        return VectorCluster(vectors: vectors, centroid: centroid)
    }

    func convergeDistance() -> Double {
        return vectors.reduce(0) { $0 + $1.distance(to: centroid) }
    }
}
