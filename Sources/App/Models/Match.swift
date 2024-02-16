//
//  Match.swift
//
//
//  Created by Luiz Sena on 09/02/24.
//

import Foundation

class Match {
    let id: Int
    var isInGame: Bool
    private var players: [Player]
    private var gameBoard: GameBoard
    var numberOfConnectedPlayers: Int {
        return players.count
    }

    init(id: Int, players: [Player], gameBoard: GameBoard) {
        self.id = id
        self.players = players
        self.gameBoard = gameBoard
        self.isInGame = false
    }

    private func gameStart() {
        if players.count == 2 {
            isInGame.toggle()
            self.turnHandler()
            players.forEach { $0.ws.send("Partida Comecou") }
        }
    }

    private func turnHandler() {
        var tempPlayers = self.players
        tempPlayers.shuffle()
        tempPlayers[0].myTurn.toggle()
    }

    func connectPlayer(newPlayer: Player) {
        self.players.append(newPlayer)
        gameStart()
        setupGameBoard(newPlayer)
    }

    func setupGameBoard(_ player: Player) {
        let wrapper = DataWrapper(data: gameBoard.board, contentType: .GameBoardToClient).toData()
        player.ws.send(raw: wrapper, opcode: .binary)
    }

}
