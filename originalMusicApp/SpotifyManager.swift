//
//  SpotifyManager.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/24.
//

import Foundation
import UIKit
import WebKit

class SpotifyManager : NSObject{
    
    // 設定
    private let clientID = SecurityToken.ClientID
    private let redirectURL = URL(string: "swiftSpotify://spotify/callback")!

    // AppRemote
    var appRemote: SPTAppRemote!
    
    // 初期化
    override init() {
        super.init()
        // AppRemoteの生成
        let configuration = SPTConfiguration(clientID: self.clientID, redirectURL: self.redirectURL)
        self.appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
    }
    
    // URLコンテキストの取得時に呼ばれる
    func onURLContext(_ url: URL) {
        let parameters = appRemote.authorizationParameters(from: url);
        if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
            print(accessToken)
            self.appRemote.connectionParameters.accessToken = accessToken
        } else if let errorDescription = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print("error : ", errorDescription)
        }
    }

    // 音楽の再生
    func authorizeAndPlayURI(_ playUrl: String) {
        self.appRemote.authorizeAndPlayURI(playUrl)
    }
}
