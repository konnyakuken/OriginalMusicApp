//
//  SearchViewController.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/19.
//

import UIKit

class SearchViewController: BaseViewController {
    // Spotifyマネージャ
    var spotifyManager: SpotifyManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Spotifyマネージャの生成
        self.spotifyManager = SpotifyManager()
    }
    
    // URLコンテキスト取得時に呼ばれる
    func onOpenURLContext(_ url: URL) {
        self.spotifyManager.onURLContext(url)
    }

    // ボタンクリック時に呼ばれる
    @IBAction func onClick(sender: UIButton) {
        self.spotifyManager.authorizeAndPlayURI("spotify:track:1I77T75FxVU3W9SfGDFwZO")
    }
    

}
