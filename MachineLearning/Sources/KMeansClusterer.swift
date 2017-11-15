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
        convergeError: Double = 0.001,
        iterationsLimit: Int = 100
    ) -> Prediction {
        guard k > 0 else {
            return []
        }

        var clusters = [VectorCluster<V>]()
        var centroids = produceCentroids(from: dataset, k: k, type: centroidsProduction)
        var convergeDistance = Double.greatestFiniteMagnitude
        var iteration = 0
        
        while abs(convergeDistance) > convergeError && iteration < iterationsLimit {
            clusters = adjustedClusters(with: dataset, centroids: centroids)
            
            let adjustedCentroids = clusters.map { $0.centroid }
            
            convergeDistance = (0 ..< k).reduce(0) { result, idx in
                result + centroids[idx].distance(to: adjustedCentroids[idx])
            }
            
            centroids = adjustedCentroids
            iteration += 1
            
            print("iteration: \(iteration), converge distance: \(convergeDistance)")
        }

        return clusters
    }
    
    private func adjustedClusters(with dataset: Dataset, centroids: [V]) -> [VectorCluster<V>] {
        var clusters = [VectorCluster<V>](repeating: .identity, count: centroids.count)
        for vector in dataset {
            let idx = centroids.indexOfNearest(to: vector) ?? 0
            clusters[idx].vectors.append(vector)
        }
        
        return clusters.map { $0.adjustingCentroid() }
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

    private static func randomCentroidIndex(with weights: [Double]) -> Int {
        let random: Double = .random * sum(weights)
        var totalSum: Double = 0
        for i in 0 ..< weights.count {
            totalSum += weights[i]
            if totalSum >= random {
                return i
            }
        }

        assertionFailure("we should never reach this point of code")
        return 0
    }
}
