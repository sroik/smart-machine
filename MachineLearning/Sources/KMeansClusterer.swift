//
//  Copyright © 2017 sroik. All rights reserved.
//

import Foundation

class KMeansClusterer<V: VectorType> {

    let dataset: Dataset
    let k: Int

    init(dataset: Dataset, k: Int) {
        assert((1 ..< dataset.count).contains(k), "incorrect k number")
        self.dataset = dataset
        self.k = min(k, dataset.count)
    }

    func fit(
        centroidsProduction: CentroidsProduction = .smartRandom,
        convergeError: Double = 0.001
    ) -> Prediction {
        guard k > 0 else {
            return []
        }

        var clusters = [VectorCluster<V>]()
        var centroids = produceCentroids(from: dataset, k: k, type: centroidsProduction)
        var convergeDistance = Double.greatestFiniteMagnitude
        var previousConvergeDistance: Double = 0

        while abs(convergeDistance - previousConvergeDistance) > convergeError && abs(convergeDistance) > convergeError {
            var adjustedClusters = [VectorCluster<V>](repeating: .identity, count: k)

            for vector in dataset {
                let idx = centroids.nearestIndex(to: vector) ?? 0
                adjustedClusters[idx].vectors.append(vector)
            }

            clusters = adjustedClusters.map { $0.adjustingCentroid() }
            let adjustedCentroids = clusters.map { $0.centroid }

            previousConvergeDistance = convergeDistance
            convergeDistance = (0 ..< k).reduce(0) { result, idx in
                result + centroids[idx].distance(to: adjustedCentroids[idx])
            }

            print("converge distance is \(convergeDistance)")
            centroids = adjustedCentroids
        }

        return clusters
    }

    private func produceCentroids(from dataset: Dataset, k: Int, type: CentroidsProduction) -> [V] {
        switch type {
        case .gradual:
            return GradualCentroidsProducer.produceCentroids(with: dataset, k: k)
        case .fastRandom:
            return FastRandomCentroidsProducer.produceCentroids(with: dataset, k: k)
        case .smartRandom:
            return SmartRandomCentroidsProducer.produceCentroids(with: dataset, k: k)
        case let .custom(kCentroids):
            assert(kCentroids.count == k, "wrong centroids number")
            return kCentroids
        }
    }
}

extension KMeansClusterer {
    typealias Dataset = [V]
    typealias Prediction = [VectorCluster<V>]

    enum CentroidsProduction {
        case smartRandom
        case fastRandom
        case gradual
        case custom(kCentroids: [V])
    }
}

final class GradualCentroidsProducer<V: VectorType> {
    static func produceCentroids(with dataset: [V], k: Int) -> [V] {
        let stride = dataset.count / k
        let result = (0 ..< k).map { dataset[$0 * stride + stride / 2] }
        return result
    }
}

final class FastRandomCentroidsProducer<V: VectorType> {
    static func produceCentroids(with dataset: [V], k: Int) -> [V] {
        return Array(dataset.shuffled().prefix(k))
    }
}

final class SmartRandomCentroidsProducer<V: VectorType> {
    static func produceCentroids(with dataset: [V], k: Int) -> [V] {
        var centroids = [dataset.random() ?? dataset[0]]
        while centroids.count < k {
            let distances = dataset.map { pow(centroids.nearest(to: $0)?.distance(to: $0) ?? 0, 2) }
            let randomIdx = randomCentroidIndex(with: distances)
            centroids.append(dataset[randomIdx])
        }
        return centroids
    }

    private static func randomCentroidIndex(with distances: [Double]) -> Int {
        let random: Double = .random * sum(distances)
        var totalSum: Double = 0
        for i in 0 ..< distances.count {
            totalSum += distances[i]
            if totalSum >= random {
                return i
            }
        }

        assertionFailure("we should never reach this point of code")
        return 0
    }
}
