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

    func moveDown(itemRow: Int, itemColumn: Int) {
        let item = matrix[itemRow][itemColumn]
        let bottomItem = matrix[itemRow + 1][itemColumn]
        let destinyItem = matrix[itemRow + 2] [itemColumn]

        if item == true && bottomItem == true && destinyItem == false {
            matrix[itemRow][itemColumn]?.toggle()
            matrix[itemRow + 1][itemColumn]?.toggle()
            matrix[itemRow + 2][itemColumn]?.toggle()
            print("Jogada Validada")
        } else {
            print("Jogada Invalida")
        }
    }

    func moveUp(itemRow: Int, itemColumn: Int){
        let item = matrix[itemRow][itemColumn]
        let topItem = matrix[itemRow - 1][itemColumn]
        let destinyItem = matrix[itemRow - 2][itemColumn]

        if item == true && topItem == true && destinyItem == false {
            matrix[itemRow][itemColumn]?.toggle()
            matrix[itemRow - 1][itemColumn]?.toggle()
            matrix[itemRow - 2][itemColumn]?.toggle()
            print("Jogada Validada")
        } else {
            print("Jogada Invalidada")
        }
    }

    func moveRight(itemRow: Int, itemColumn: Int) {
        let item = matrix[itemRow][itemColumn]
        let rightItem = matrix[itemRow][itemColumn + 1]
        let destinyItem = matrix[itemRow][itemColumn + 2]

        if item == true && rightItem == true && destinyItem == false {
            matrix[itemRow][itemColumn]?.toggle()
            matrix[itemRow][itemColumn + 1]?.toggle()
            matrix[itemRow][itemColumn + 2]?.toggle()
            print("Jogada Validada")
        } else {
            print("Jogada Invalidada")
        }
    }
    func moveLeft(itemRow: Int, itemColumn: Int) {
        let item = matrix[itemRow][itemColumn]
        let leftItem = matrix[itemRow][itemColumn - 1]
        let destinyItem = matrix[itemRow][itemColumn - 2]

        if item == true && leftItem == true && destinyItem == false {
            matrix[itemRow][itemColumn]?.toggle()
            matrix[itemRow][itemColumn - 1]?.toggle()
            matrix[itemRow][itemColumn - 2]?.toggle()
            print("Jogada Validada")
        } else {
            print("Jogada Invalidada")
        }
    }

}
