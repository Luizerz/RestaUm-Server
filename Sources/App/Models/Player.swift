//
//  Player.swift
//
//
//  Created by Luiz Sena on 09/02/24.
//

import Foundation
import Vapor

class Player {
    let id: UUID
    let ws: WebSocket
    var myTurn: Bool { didSet {
        delegate?.sendTurn(self)
    }}
    var playerScore: Int {
        return score
    }
    private var score: Int = 0
    let delegate: GameSystemPlayerDelegate?

    init(id: UUID = UUID(), ws: WebSocket, myTurn: Bool = false, delegate: GameSystemPlayerDelegate? = nil) {
        self.id = id
        self.ws = ws
        self.myTurn = myTurn
        self.delegate = delegate
    }
    func plusScore() {
        self.score += 1
    }
}


protocol GameSystemPlayerDelegate {
    func sendTurn(_ player: Player)
}
