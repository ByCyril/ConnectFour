//
//  ViewController.swift
//  ConnectFour
//
//  Created by Cyril Garcia on 1/18/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GridDelegate {

    var game: ConnectFour!
    var grid: Grid!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        game = ConnectFour()
        grid = Grid(frame: self.view.bounds, vc: self, delegate: self)
        self.view.addSubview(grid)
        
    }
    
    func selectedPiece(_ r: Int, _ c: Int) {
    
        game.makePlay(at: c) { (results) in
            let r = results.location?.r
            let c = results.location?.c
            
            switch results.gameState {
            case .invalidInput:
                self.grid.columnIsFull(to: self)
                
            case .playerOneWins:
                self.grid.placePiece(r!, c!, .red)
                self.grid.declareWinner("Red Wins!", to: self)
                
            case .playerTwoWins:
                self.grid.placePiece(r!, c!, .blue)
                self.grid.declareWinner("Blue Wins!", to: self)
                
            case .tie:
                self.grid.tieGame(to: self)
                
            case .playerOneTurn:
                self.grid.placePiece(r!, c!, .red)
                
            case .playerTwoTurn:
                self.grid.placePiece(r!, c!, .blue)
                
            default:
                break
                
            }
        }
        
        
    }
    

    

}

