//
//  Grid.swift
//  ConnectFour
//
//  Created by Cyril Garcia on 1/21/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

protocol GridDelegate {
    func selectedPiece(_ r: Int, _ c: Int)
}

class Grid: UIView {
    
    private var delegate: GridDelegate!
    private var vc: UIViewController!
    
    private var gridPieces = [[Piece]]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    init(frame: CGRect, vc: UIViewController, delegate: GridDelegate) {
        super.init(frame: frame)
        self.vc = vc
        self.delegate = delegate
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
    
        var stacks = [UIStackView]()
        
        for r in 0..<6 {
            let stack = UIStackView()
            stack.distribution = .fillProportionally
            self.addSubview(stack)
            
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
            stack.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            if stacks.isEmpty {
                stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
            } else {
                stack.topAnchor.constraint(equalTo: stacks.last!.bottomAnchor, constant: 20).isActive = true
            }
            
            var rowPieces = [Piece]()
            
            for c in 0..<7 {
                
                let piece = Piece(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                piece.row = r
                piece.column = c
                rowPieces.append(piece)
                piece.addTarget(self, action: #selector(selectedPiece(_:)), for: .touchUpInside)
                stack.addArrangedSubview(piece)
            }
            
            gridPieces.append(rowPieces)
            stacks.append(stack)
            
        }
        
        createResetButton()
        
    }
    
    public func tieGame(to vc: UIViewController) {
        showMessage("Game Over!", "Tie Game!", vc: vc)
    }
    
    public func columnIsFull(to vc: UIViewController) {
        showMessage("Try again", "This column is already full", vc: vc)
    }
    
    public func declareWinner(_ winner: String, to vc: UIViewController) {
        showMessage("Game Over!", winner, vc: vc)
        disablePieces()
    }
    
    public func placePiece(_ r: Int, _ c: Int, _ color: UIColor) {
        let piece = gridPieces[r][c]
        piece.backgroundColor = color
    }
    
    private func disablePieces() {
        for row in gridPieces {
            for piece in row {
                piece.isEnabled = false
            }
        }
    }
    
    @objc private func selectedPiece(_ sender: Piece) {
        delegate.selectedPiece(sender.row!, sender.column!)
    }
    
    @objc private func restartGame() {
        for row in gridPieces {
            for piece in row {
                piece.isEnabled = true
                piece.backgroundColor = .white
            }
        }
    }
    
    private func createResetButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 25))
        button.setTitle("Restart", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action:#selector(restartGame), for: .touchUpInside)
        self.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        button.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        
    }
    
    private func showMessage(_ title: String, _ message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(cancel)
        vc.present(alert, animated: true, completion: nil)
    }
    
}
