//
//  PlaylistDetailViewController.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/19.
//

import UIKit
import RealmSwift

class PlaylistDetailViewController: BaseViewController {
    
    var id = ""
    @IBOutlet var playlistTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //back off
        //self.navigationItem.hidesBackButton = true
    }
    
    //Viewが表示される直前に呼ばれる。
    override func viewWillAppear(_ animated: Bool) {
        let playlistName = realm.objects(Playlist.self).filter("id == %@",Int((id as NSString).doubleValue))[0].playlist_name
        playlistTitle.text = playlistName
    }


}
