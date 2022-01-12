//
//  CharData.swift
//  Rick-diculous
//
//  Created by 梁程 on 2021/11/16.
//

import Foundation

struct CharData: Decodable {
    var results:[Char]

}

struct Char: Decodable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var image: String
    var episode: [String]
}


