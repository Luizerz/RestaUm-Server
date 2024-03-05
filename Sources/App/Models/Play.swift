//
//  Play.swift
//
//
//  Created by Luiz Sena on 04/03/24.
//

import Foundation

struct Play: Codable {
    let row: Int
    let column: Int
    let playType: PlayType
}

enum PlayType: Codable {
    case right
    case left
    case top
    case bottom
}
