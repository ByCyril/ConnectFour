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
        grid = Grid(frame: self.view.bounds)
        grid.delegate = self
        self.view.addSubview(grid)
        
    }
    
    func selectedPiece(_ r: Int, _ c: Int) {
    
        game.makePlay(at: c) { (results) in
          
            switch results.gameState {
            case .invalidInput:
                print("try again")
            case .playerOneWins:
                print("Red Wins")
            case .playerTwoWins:
                print("Blue Wins")
            case .tie:
                print("Tie Game")
            case .playerOneTurn:
                let r = results.location!.r
                let c = results.location!.c
                self.grid.placePiece(r, c, .red)
            case .playerTwoTurn:
                let r = results.location!.r
                let c = results.location!.c
                self.grid.placePiece(r, c, .blue)
            default:
                break
                
            }
        }
        
        
    }
    

    

}

