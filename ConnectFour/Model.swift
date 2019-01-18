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
    
    public func makePlay(at column: Int, completion: (_ success: Bool, _ placement: (Int, y: Int)?) -> Void) {
        
        var r = 0
        var row = grid[r]
//        [0,0,1,4,0,1,4]
        
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
            turnState *= -1
            completion(true, (r, column))
        } else {
            completion(false, nil)
        }
        
        
    }
    
    
    public func seeGrid() {
        for g in grid {
            print(g)
        }
    }
    
    
}
