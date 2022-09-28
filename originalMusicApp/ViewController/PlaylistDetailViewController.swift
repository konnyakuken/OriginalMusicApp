//
//  PlaylistDetailViewController.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/19.
//

import UIKit
import RealmSwift

class PlaylistDetailViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    var id = ""
    @IBOutlet var playlistTitle: UILabel!
    @IBOutlet var musicTable: UITableView!

    
    var toSearchMusicButton:UIBarButtonItem!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicTable.dataSource = self
        musicTable.delegate = self
        //追加ボタン設定
        toSearchMusicButton = UIBarButtonItem(title: "曲を追加する", style: .done, target: self, action: #selector(toAddMusic(_:)))
        toSearchMusicButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = toSearchMusicButton
        //back off
        //self.navigationItem.hidesBackButton = true
        //table線の設定
        // 線の種類
        musicTable.separatorStyle = .singleLine
        // 線の色
        musicTable.separatorColor = UIColor(red: 86/255, green: 88/255, blue: 79/255, alpha: 1.0)
        // 先のインセット
        musicTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //Viewが表示される直前に呼ばれる。
    override func viewWillAppear(_ animated: Bool) {
        let playlistName = realm.objects(Playlist.self).filter("id == %@",Int((id as NSString).doubleValue))[0].playlist_name
        playlistTitle.text = playlistName
        
        let results = realm.objects(Playlist.self).filter("id == %@",Int((id as NSString).doubleValue))[0].musics
        print(results)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let results = realm.objects(Playlist.self).filter("id == %@",Int((id as NSString).doubleValue))[0].musics
        //セクションの中のセルの数
        return results.count
    }
    
    //セルに表示する内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath)
        let results = realm.objects(Playlist.self).filter("id == %@",Int((id as NSString).doubleValue))[0].musics
        cell.textLabel?.text = "\(results[indexPath.row].name)"
        cell.textLabel?.textColor = .white
        let imageUrl:UIImage = self.getImageByUrl(url: results[indexPath.row].thumbnail)
        cell.imageView?.image = imageUrl
        //cell.detailTextLabel?.text = "\(results[indexPath.row].artist)"
        cell.detailTextLabel?.text = "\(results[indexPath.row].id)"
        
        return cell
    }
    
    //Cellがクリックされた時によばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let results = realm.objects(Playlist.self).filter("id == %@",Int((id as NSString).doubleValue))[0].musics
        //曲情報を送信
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "musicDetail")as? MusicViewController else
        { return }
        vc.playlistID = String(id)
        vc.musicID = String(results[indexPath.row].id)
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    @objc func toAddMusic(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "SearchMusic")as? SearchViewController else
        { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //曲追加(仮実装)
    @IBAction func addMusic(){
        let playlist = realm.objects(Playlist.self).filter("id == %@",Int((id as NSString).doubleValue))[0]

        let addMusic = Music()
        let music = readMusic()
        if music != nil {
            let musics = realm.objects(Music.self).count
            addMusic.id = musics + 1
        } else {
            addMusic.id = 1
        }
        
        addMusic.spotify_id = ""
        addMusic.artist = "test\(count)"
        addMusic.album = "test\(count)"
        addMusic.name = "\(count)test"
        addMusic.thumbnail = "https://i.scdn.co/image/ab67616d0000b27325bc2af2934fdaaf9e70814b"
        try! realm.write {
            playlist.musics.append(addMusic)
        }
        count += 1
    }
    
    

}
