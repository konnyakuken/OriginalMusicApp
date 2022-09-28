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
        self.spotifyManager.authorizeAndPlayURI("spotify:track:5oEIkRwgx72M3fMWSowKxQ")
    }
    
    private let clientID = SecurityToken.ClientID
    private let clientSecret = SecurityToken.ClientSecret
    
    // ボタンクリック時に呼ばれる
    @IBAction func search(sender: UIButton) {
        let url = URL(string: "https://accounts.spotify.com/api/token")!  //URLを生成
        var request = URLRequest(url: url)               //Requestを生成
        request.httpMethod = "POST"
        guard let credentialData = "\(clientID):\(clientSecret)".data(using: String.Encoding.utf8) else { return }
        let credential = credentialData.base64EncodedString(options: [])
        let basicData = "Basic \(credential)"
        request.setValue(basicData, forHTTPHeaderField: "Authorization")
        request.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded"]
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in  //非同期で通信を行う
            guard let data = data else { return }
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: [])  // DataをJsonに変換
                print(object)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    
    

}
