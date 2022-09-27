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
    var toSearchMusicButton:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //追加ボタン設定
        toSearchMusicButton = UIBarButtonItem(title: "曲を追加する", style: .done, target: self, action: #selector(toAddMusic(_:)))
        toSearchMusicButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = toSearchMusicButton
        //back off
        //self.navigationItem.hidesBackButton = true
    }
    
    //Viewが表示される直前に呼ばれる。
    override func viewWillAppear(_ animated: Bool) {
        let playlistName = realm.objects(Playlist.self).filter("id == %@",Int((id as NSString).doubleValue))[0].playlist_name
        playlistTitle.text = playlistName
    }
    
    @objc func toAddMusic(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "SearchMusic")as? SearchViewController else
        { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addMusic(){
        
    }


}
