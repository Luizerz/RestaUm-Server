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
    case ChatTextToClient
    case GameBoardToClient

    case ChatTextToServer
}
