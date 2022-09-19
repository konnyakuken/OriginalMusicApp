//
//  CustomToolbar.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/19.
//

import Foundation
import UIKit

class CustomToolbar: UIToolbar {

    let addHeight:CGFloat = 20
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        //バーの色
        self.barTintColor = UIColor.orange
        //アイテムの色
        self.tintColor = UIColor.white
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = super.sizeThatFits(size)
        newSize.height += addHeight //通常よりどれだけ大きくするか
        
        return newSize
    }

}
