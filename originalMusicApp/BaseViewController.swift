//
//  BaseViewController.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/19.
//

import UIKit
import RealmSwift

class BaseViewController: UIViewController {
    
    let realm = try! Realm()

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
    
    func read() -> Playlist?{
        return realm.objects(Playlist.self).first
    }

}
