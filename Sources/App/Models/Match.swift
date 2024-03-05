//
//  Match.swift
//
//
//  Created by Luiz Sena on 09/02/24.
//

import Foundation
import Vapor

class Match {
    let id: Int
    var isGameStarted: Bool
    private var players: [Player]
    private var gameBoard: GameBoard {
        didSet {
            print("Gameboard Mudou")
        }
    }

    var numberOfConnectedPlayers: Int {
        return players.count
    }

    init(id: Int, players: [Player], gameBoard: GameBoard) {
        self.id = id
        self.players = players
        self.gameBoard = gameBoard
        self.isGameStarted = false
    }

    private func gameStart() {
        if players.count == 2 {
            isGameStarted.toggle()
            self.turnHandler()
        }
    }

    private func turnHandler() {
        var tempPlayers = self.players
        tempPlayers.shuffle()
        tempPlayers[0].myTurn.toggle()

    }

    func connectPlayer(newPlayer: Player) {
        self.players.append(newPlayer)
        setupGameBoard(newPlayer)
        sendNumberOfPlayersConnected()
        gameStart()
    }

    func play(_ p: Play, from: Player) {
        from.plusScore()
        switch p.playType {
        case .right:
            gameBoard.moveRight(itemRow: p.row, itemColumn: p.column)
            sendGameboard(from)
        case .left:
            gameBoard.moveLeft(itemRow: p.row, itemColumn: p.column)
            sendGameboard(from)
        case .top:
            gameBoard.moveUp(itemRow: p.row, itemColumn: p.column)
            sendGameboard(from)
        case .bottom:
            gameBoard.moveDown(itemRow: p.row, itemColumn: p.column)
            sendGameboard(from)
        }
    }

    func removePlayer(player: Player) {
        self.players.removeAll { p in
            p.id == player.id
        }
    }

    func playerSurrender(_ player: Player) {
        let wrapper = DataWrapper(data: Data(), contentType: .Lose).toData()
        player.ws.send(raw: wrapper, opcode: .binary)
        self.players.forEach {
            if $0.id != player.id {
                let wrapper = DataWrapper(data: Data(), contentType: .Win).toData()
                $0.ws.send(raw: wrapper, opcode: .binary)
                _ = $0.ws.close(code: .normalClosure)
            }
        }
    }

    private func sendGameboard(_ player: Player) {
        self.players.forEach {
            if $0.id != player.id {
                let wrapper = DataWrapper(data: gameBoard.board, contentType: .PlayResponseToClient).toData()
                $0.ws.send(raw: wrapper, opcode: .binary)
            }
            $0.myTurn.toggle()
        }
    }

    private func setupGameBoard(_ player: Player) {
        let wrapper = DataWrapper(data: gameBoard.board, contentType: .GameBoardToClient).toData()
        player.ws.send(raw: wrapper, opcode: .binary)
    }

    private func sendNumberOfPlayersConnected() {
        let dataWrapper = DataWrapper(data: self.players.count.toData(), contentType: .NumberOfPlayerToClient)
        players.forEach { $0.ws.send(raw: dataWrapper.toData(), opcode: .binary)}
    }

    func chatting(_ text: String, from player: Player) {
        self.players.forEach {
            if $0.id != player.id {
                $0.ws.send(text)
            }
        }
    }
}

extension Int {
    func toData() -> Data {
        return try! JSONEncoder().encode(self)
    }
}

extension Bool {
    func toData() -> Data {
        return try! JSONEncoder().encode(self)
    }
}
