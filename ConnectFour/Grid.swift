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
    
    public var delegate: GridDelegate!
    
    private var gridPieces = [[Piece]]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
    
        var stacks = [UIStackView]()
        
        for r in 0..<6 {
            let stack = UIStackView()
            stack.distribution = .equalSpacing
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
        
    }

    public func showMessage(_ title: String, _ message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(cancel)
        vc.present(alert, animated: true, completion: nil)
    }
    
    public func declareWinner() {
        for rowPieces in gridPieces {
            for p in rowPieces {
                p.isEnabled = false
            }
        }
    }
    
    public func placePiece(_ r: Int, _ c: Int, _ color: UIColor) {
        let piece = gridPieces[r][c]
        piece.backgroundColor = color
    }
    
    @objc private func selectedPiece(_ sender: Piece) {
        delegate.selectedPiece(sender.row!, sender.column!)
    }
    
}
