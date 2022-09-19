//
//  BaseViewController.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/19.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        extendedLayoutIncludesOpaqueBars = true
        setBackBarButton()
        // Do any additional setup after loading the view.
    }
    

    func setBackBarButton() {
            let backItem  = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
            backItem.tintColor = .white
            navigationItem.backBarButtonItem = backItem
            //navigationController?.navigationBar.backIndicatorImage = hogeImage
            //navigationController?.navigationBar.backIndicatorTransitionMaskImage = hogeImage
    }

}
