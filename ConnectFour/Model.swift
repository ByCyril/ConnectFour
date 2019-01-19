//
//  Model.swift
//  ConnectFour
//
//  Created by Cyril Garcia on 1/18/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class Model {
    
    private var grid = [[0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0]]
    
    private var turnState = 1
    
    init() {
        
    }
    
    public func makePlay(at column: Int, completion: ((winner: Bool, player: Int?)) -> Void) {
        
        var r = 0
        var row = grid[r]
        
        if row[column] == 0 {
            while r < grid.count {
                row = grid[r]
                if row[column] != 0 {
                    break
                } else {
                    r += 1
                }
            }
            
            grid[r - 1][column] = turnState
            self.turnState *= -1
            self.seeGrid()
           
        } else {
            completion((false, nil))
        }
    }
    
    private func checkWinner(callback: (_ winner:Bool) -> Void) {
        for row in grid {
            for i in 0..<4 {
                
                if row[i] != 0 {
                    let a = row[i] == row[i + 1]
                    let b =  row[i + 1] == row[i + 2]
                    let c = row[i + 2] == row[i + 3]
                    
                    if a && b && c {
                        print(row[i], row[i + 1],row[i + 2],row[i + 3])
                        callback(true)
                        break
                    }
                }                
            }
        }
    }
    
    
    public func seeGrid() {
        for g in grid {
            print(g)
        }
    }
    
    
}
