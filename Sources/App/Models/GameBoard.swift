//
//  GameBoard.swift
//
//
//  Created by Luiz Sena on 16/02/24.
//

import Foundation

class GameBoard {
    private var matrix = [[Bool?]]()
    var board: Data {
        return try! JSONEncoder().encode(self.matrix)
    }

    init() {
        setupMatrix()
    }

    private func setupMatrix() {
        for i in 0 ... 6 {
            if (i == 0 || i == 1 || i == 5 || i == 6) {
                self.matrix.append([nil,nil,true,true,true,nil,nil])
            } else if (i == 3){
                self.matrix.append([true,true,true,false,true,true,true])
            } else {
                self.matrix.append([true,true,true,true,true,true,true])
            }
        }
    }
}
