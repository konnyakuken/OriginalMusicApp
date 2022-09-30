//
//  MusicViewController.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/28.
//

import UIKit
import RealmSwift

class MusicViewController: BaseViewController {
    
    // Spotifyマネージャ
   var spotifyManager: SpotifyManager!
    
    var playlistID = ""
    var musicID = ""
    
    @IBOutlet var musicName:UILabel!
    @IBOutlet var musicJaket:UIImageView!
    @IBOutlet var artist:UILabel!
    @IBOutlet var playButton:UIButton!
    @IBOutlet var nextButton:UIButton!
    @IBOutlet var backButton:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ボタン設定
        self.nextButton.setImage(UIImage(systemName: "forward.circle"), for: .normal)
        self.backButton.setImage(UIImage(systemName: "backward.circle"), for: .normal)
        self.playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        // Spotifyマネージャの生成
        self.spotifyManager = SpotifyManager()

    }
    
    // URLコンテキスト取得時に呼ばれる
   func onOpenURLContext(_ url: URL) {
       self.spotifyManager = SpotifyManager()
       self.spotifyManager.onURLContext(url)
   }
    
    // ボタンクリック時に呼ばれる
    @IBAction func onClick(sender: UIButton) {
        let music = realm.objects(Music.self).filter("id == \(musicID)")[0]
        self.spotifyManager.authorizeAndPlayURI(music.spotify_id)
    }
    
    //Viewが表示されるたびに呼ばれる。
    override func viewWillAppear(_ animated: Bool) {
        let music = realm.objects(Music.self).filter("id == \(musicID)")[0]
        musicName.text = music.name
        artist.text = music.artist
        if(music.thumbnail == "0"){
            self.musicJaket.image = UIImage(named: "noImage")
        }else{
            let imageUrl:UIImage = self.getImageByUrl(url: music.thumbnail)
            self.musicJaket.image = imageUrl
        }
        
    }
    
    @IBAction func changeSongStatus() {
        self.spotifyManager.appRemote?.playerAPI?.resume() // 一時停止
    }
    
    
}
