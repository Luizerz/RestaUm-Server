//
//  DataWrapper.swift
//
//
//  Created by Luiz Sena on 16/02/24.
//

import Foundation

struct DataWrapper: Codable {
    let data: Data
    let contentType: ContentType

    func toData() -> Data {
        return try! JSONEncoder().encode(self)
    }
}

enum ContentType: Codable {
    //To Client DTO
    case ChatTextToClient
    case GameBoardToClient
    case PlayResponseToClient
    case NumberOfPlayerToClient
    case TurnToClient
    case Lose
    case Win
    //To Server DTO
    case ChatTextToServer
    case PlayToServer
    case SurrenderToServer
}
