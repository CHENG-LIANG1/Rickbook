//
//  LocationData.swift
//  Rick-diculous
//
//  Created by 梁程 on 2021/11/17.
//

import Foundation

struct LocationData: Decodable {
    var results: [Location]
}

struct Location: Decodable {
    var name: String
    var type: String
    var dimension: String
}
