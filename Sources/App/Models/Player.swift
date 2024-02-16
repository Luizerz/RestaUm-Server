//
//  Player.swift
//
//
//  Created by Luiz Sena on 09/02/24.
//

import Foundation
import Vapor

struct Player {
    let id: UUID
    let ws: WebSocket
    var myTurn: Bool
    var playerScore: Int {
        return score
    }
    private var score: Int = 0

    init(id: UUID = UUID(), ws: WebSocket, myTurn: Bool = false) {
        self.id = id
        self.ws = ws
        self.myTurn = myTurn
    }
}


