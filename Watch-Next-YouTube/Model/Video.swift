//
//  Video.swift
//  watch-next-swift-ui-test
//
//  Created by Mikolaj Lukasik on 15/05/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import Foundation

struct Video : Identifiable, Hashable {
    var id = UUID()
    let imageName: String
    let title: String
    let author: String
    let duration: Double
    let numberOfViews: Int
    
}
