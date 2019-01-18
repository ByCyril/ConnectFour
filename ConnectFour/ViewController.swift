//
//  ViewController.swift
//  ConnectFour
//
//  Created by Cyril Garcia on 1/18/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = Model()
        
        let moves = [0,0,1,4,0,1,4,0,0,0]
        
        for move in moves {
            model.makePlay(at: move) { (success, position) in
                if success {
                    print(position!.0, position!.y)
                }
            }
        }
        
        model.seeGrid()

    }

    

}

