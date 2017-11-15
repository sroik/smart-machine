//
//  Copyright © 2017 sroik. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        
        let points = [
            Point(0.5, 0.5),
            Point(1.5, 1),
            Point(1, 1.5),
            Point(1.5, 1.5),
            
            Point(5, 5),
            Point(4, 5),
            Point(5, 3),
            Point(4, 4),
            
            Point(9, 9),
            Point(9, 10),
            Point(10, 10),
            Point(8, 8),
        ]
        
        let clusterer = KMeansClusterer(dataset: points, k: 3)
        let clusters = clusterer.fit()
        
        print("centroids: \(clusters.map { $0.centroid })")
    }
}
