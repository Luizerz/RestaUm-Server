//
//  GameSystem.swift
//
//
//  Created by Luiz Sena on 08/02/24.
//

import Foundation
import Vapor

class GameSystem {
    var matches: [Match] = [] { didSet { print(self.matches.count)}}

    private func matchHandler() -> Int {
        let match = matches.firstIndex { $0.numberOfConnectedPlayers < 2 && !$0.isGameStarted }
        if match == nil {
            matches.append(Match(id: matches.count, players: [], gameBoard: GameBoard()))
            return matches.firstIndex { $0.numberOfConnectedPlayers < 2 && !$0.isGameStarted }!
        } else {
            return match!
        }
    }

    func connect(_ req: Request, _ ws: WebSocket) {
        let matchID = matchHandler()
        let newPlayer = Player(ws: ws, delegate: self)
        let match = matches[matchID]
        match.connectPlayer(newPlayer: newPlayer)
        
        newPlayer.ws.onText { ws, text in
            match.chatting(text, from: newPlayer)
        }
        newPlayer.ws.onBinary { ws, byteBuffer in
            let dataWrapper = try! JSONDecoder().decode(DataWrapper.self, from: byteBuffer)
            self.verifyDTO(dataWrapper: dataWrapper, match: match, player: newPlayer)
        }
        newPlayer.ws.onClose.whenSuccess { callback in
            match.removePlayer(player: newPlayer)
            if match.numberOfConnectedPlayers == 0 { self.matches.removeAll { $0.id == match.id } }
        }
    }

    private func verifyDTO(dataWrapper: DataWrapper, match: Match, player: Player) {
        switch dataWrapper.contentType {
        case .ChatTextToServer:
            print(dataWrapper.contentType)
        case .PlayToServer:
            let data = try! JSONDecoder().decode(Play.self, from: dataWrapper.data)
            match.play(data, from: player)
        case .SurrenderToServer:
            match.playerSurrender(player)
        default:
            print("Nao é pra acontecer")
        }
    }
}

extension GameSystem: GameSystemPlayerDelegate {
    func sendTurn(_ player: Player) {
        print(player.id, player.myTurn)
        let wrapper = DataWrapper(data: player.myTurn.toData(), contentType: .TurnToClient).toData()
        player.ws.send(raw: wrapper, opcode: .binary)
    }
}

