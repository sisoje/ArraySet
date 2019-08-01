//
//  Array+Int+Random.swift
//  ArraySetTests
//
//  Created by Lazar Otasevic on 7/27/19.
//  Copyright © 2019 lazar. All rights reserved.
//

import GameplayKit

extension Array where Element == Int {
    static func makeRandom(_ len: Int) -> [Int] {
        let mt = GKMersenneTwisterRandomSource(seed: 55)
        return (0 ..< len).map { _ in
            mt.nextInt()
        }
    }
}
