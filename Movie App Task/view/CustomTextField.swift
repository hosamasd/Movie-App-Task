//
//  CustomTextField.swift
//  Movie App Task
//
//  Created by hosam on 8/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//


import UIKit

class CustomTextField: UITextField {
    
    let padding:CGFloat
    let height:CGFloat
    
    init(padding:CGFloat,height:CGFloat) {
        self.padding = padding
        self.height = height
        super.init(frame: .zero)
        self.layer.cornerRadius = height / 2
        backgroundColor = .white
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: height)
        
    }
}
