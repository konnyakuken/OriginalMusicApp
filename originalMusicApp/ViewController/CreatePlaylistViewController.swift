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
    @IBOutlet var addPlaylistButton: UIButton!
    
    var newId = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    
    
    @IBAction func save(){
        let playlistTitle: String = titleTextField.text!

        if(playlistTitle != ""){
            addPlaylist(playlistTitle: playlistTitle)
            let alert: UIAlertController = UIAlertController(title: "成功", message: "作成しました", preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(title: "OK", style: .default,handler: {_ in self.toNext()})
            )
            present(alert,animated:true,completion: nil)
        }else{
            let alert: UIAlertController = UIAlertController(title: "失敗", message: "すべての項目を埋めてください", preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(title: "OK", style: .default,handler: nil)
            )
            present(alert,animated:true,completion: nil)
        }

    }
    
    func toNext(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "PlaylistDetail")as? PlaylistDetailViewController else
        { return }
        vc.id = String(newId)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addPlaylist(playlistTitle:String){
        let playlist: Playlist? = read()
        //インスタンス作成
        let newPlaylist = Playlist()
        newPlaylist.playlist_name = playlistTitle
        
        if playlist != nil {
            let results = realm.objects(Playlist.self)
            newPlaylist.id = (Int(results[results.count - 1].id)) + 1
            newId = (Int(results[results.count - 1].id)) + 1
        } else {
            newPlaylist.id = 1
            newId = 1
        }
        try! realm.write{
            realm.add(newPlaylist)
        }
        print(realm.objects(Playlist.self))
    }
    


}
