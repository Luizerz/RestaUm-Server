//
//  GameSystem.swift
//
//
//  Created by Luiz Sena on 08/02/24.
//

import Foundation
import Vapor

class GameSystem {
    //Matchs -> //GameBoard & Players
    var matches: [Match] = []
    private func matchHandler() -> Int {
        let match = matches.first { $0.numberOfConnectedPlayers < 2 && !$0.isInGame }
        if match == nil {
            matches.append(Match(id: matches.count, players: [], gameBoard: GameBoard()))
            return matches.count - 1
        } else {
            return match!.id
        }
    }
    func connect(_ req: Request, _ ws: WebSocket) {
        let matchID = matchHandler()
        
        let newPlayer = Player(ws: ws)
        let match = matches[matchID]
        match.connectPlayer(newPlayer: newPlayer)
    }
}
