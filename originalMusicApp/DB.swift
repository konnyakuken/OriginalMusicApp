//
//  DB.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/19.
//

import Foundation
import RealmSwift
import MediaPlayer

class Playlist: Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var playlist_name: String = ""
    
    let musics = List<Music>()
}

class Music: Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var spotify_id: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var artist: String = ""
    @objc dynamic var album: String = ""
    @objc dynamic var thumbnail: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var duration: Int = 0
}




