//
//  Piece.swift
//  ConnectFour
//
//  Created by Cyril Garcia on 1/21/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class Piece: UIButton {
    
    var row: Int!
    var column: Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
    }
    
}
