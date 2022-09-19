//
//  CreatePlaylistViewController.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/19.
//

import UIKit
import RealmSwift


class CreatePlaylistViewController: BaseViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var detailTextField: UITextView!
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    

    func read() -> Playlist?{
        return realm.objects(Playlist.self).first
    }
    
    

}
