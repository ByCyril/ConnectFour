//
//  ViewController.swift
//  ConnectFour
//
//  Created by Cyril Garcia on 1/18/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.layout()
        self.view.backgroundColor = .white
        
    }
    
    func layout() {
        
        var x = 20
        
        for i in 0..<7 {
            self.createButton(x, i)
            x += 50
        }
    }
    
    func createButton(_ x: Int, _ tag: Int) {
        let button = UIButton(frame: CGRect(x: x, y: 200, width: 50, height: 50))
        button.tag = tag
        button.setTitle("O", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(ViewController.play(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func play(_ sender: UIButton) {
        print("clicked")
        print(sender.tag)
        model.makePlay(at: sender.tag) { (results) in
            print(results.winner, results.player)
            if results.winner {
                print("here")
                print("Winner", results.player!)
                
            } else {
                print("here2")

                self.model.seeGrid()
            }
        }
    }

    

}

