//
//  BaseViewController.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/19.
//

import UIKit
import RealmSwift
import MediaPlayer

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
    
    func readMusic() -> Music?{
        return realm.objects(Music.self).first
    }
    
    func getImageByUrl(url: String) -> UIImage{
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
    }

}

struct MusicDetail {
    var spotify_id: String
    var type: String
    var artist: String
    var album: String
    var thumbnail: String
    var name: String
    var duration: Int
}

struct LocalMusicDetail {
    //var music_data:MPMediaItemCollection
    var music_data:String
    var type: String
    var artist: String
    var album: String
    //var thumbnail: MPMediaItemArtwork
    var thumbnail: String
    var name: String
}

struct LocalMusicData{
    var id:String
    var music_data:MPMediaItemCollection
}
