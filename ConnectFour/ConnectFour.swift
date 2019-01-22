//
//  Model.swift
//  ConnectFour
//
//  Created by Cyril Garcia on 1/18/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

enum GameState {
    case playerOneWins
    case playerTwoWins
    case tie
    case gameOn
    case invalidInput
    case playerOneTurn
    case playerTwoTurn
}

class ConnectFour {
    
    private var grid = [[0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0]]

    private var gameOver = false
    private var turnState = 1
    private var totalTurns = 0
    
    init() {
   
    }
    
    public func makePlay(at column: Int, completion:  ((gameState: GameState, location: (r: Int, c: Int)?)) -> Void) {
        
        if grid.first![column] != 0 {
            completion((GameState.invalidInput, (nil)))
        } else {
            for r in (0..<6).reversed() {
                if grid[r][column] == 0 {
                    grid[r][column] = turnState
                    totalTurns += 1
                    completion((currentGameState(), (r, column)))
                    break
                }
            }
        }
    }
    
    private func currentGameState() -> GameState {
        
        if winnerFound() {
            clearGrid()
            if turnState == 1 {
                return .playerOneWins
            } else {
                return .playerTwoWins
            }
        } else if totalTurns == 42 {
            return .tie
        } else if turnState == 1 {
            turnState *= -1
            return .playerOneTurn
        } else if turnState == -1 {
            turnState *= -1
            return .playerTwoTurn
        }
        
        return .gameOn
    }
    
    private func winnerFound() -> Bool {
        return checkVertical() || checkHorizontal() || checkLeftDiagonal() || checkRightDiagonal()
    }
    
    private func clearGrid() {
        grid = [[0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0]]
    }
    
    private func checkHorizontal() -> Bool {

        for r in 0..<6 {
            for c in 0..<4 {
                
                let w = grid[r][c]
                let x = grid[r][c + 1]
                let y = grid[r][c + 2]
                let z = grid[r][c + 3]
                
                if w == x && w == y && w == z && w != 0 {
                    return true
                }
            }
        }
        return false
    }
    
    private func checkVertical() -> Bool {

        for r in 0..<3 {
            for c in 0..<7 {
                
                let w = grid[r][c]
                let x = grid[r + 1][c]
                let y = grid[r + 2][c]
                let z = grid[r + 3][c]
                
                if w == x && w == y && w == z && w != 0 {
                    return true
                }
                
            }
        }
        return false
    }
    
    private func checkLeftDiagonal()  -> Bool{

        for r in 0..<3 {
            for c in 0..<4 {
                let w = grid[r][c]
                let x = grid[r + 1][c + 1]
                let y = grid[r + 2][c + 2]
                let z = grid[r + 3][c + 3]
                
                if w == x && w == y && w == z && w != 0 {
                    return true
                }
            }
        }
        return false
    }
    
    private func checkRightDiagonal() -> Bool {

        for r in 0..<3 {
            for c  in 3..<7 {
                let w = grid[r][c]
                let x = grid[r + 1][c - 1]
                let y = grid[r + 2][c - 2]
                let z = grid[r + 3][c - 3]
                
                if w == x && w == y && w == z && w != 0 {
                    return true
                }
            }
        }
        return false
    }

}
