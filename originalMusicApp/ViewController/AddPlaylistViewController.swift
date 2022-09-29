//
//  AddPlaylistViewController.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/19.
//

import UIKit
import RealmSwift

class AddPlaylistViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var Musiclist = [MusicDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = true
        
        // UICollectionView のデータを更新した後に追加
        collectionView.reloadData()
        
        // collectionViewレイアウト設定(行間)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        collectionView.collectionViewLayout = layout
    }
    
    //Viewが表示されるたびに呼ばれる。
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let result = realm.objects(Playlist.self).count
        //セクションの中のセルの数
        return result
    }
    
    //セルに表示する内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //セルの生成
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistCell", for: indexPath)
        //label設定
        let label = cell.contentView.viewWithTag(1) as! UILabel
        
        let playlistDB = realm.objects(Playlist.self).filter("id == %@",indexPath.row)
        if (!playlistDB.isEmpty){
            label.text = String(playlistDB[0].playlist_name)
        }
        
        return cell
    }
    
    //Cellがクリックされた時によばれます
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addMusic(num: indexPath.row)

        let playlistId = realm.objects(Playlist.self).filter("id == %@",indexPath.row+1)[0].id
        toPlaylistDetail(id: playlistId)
    }
    
    
    //セルのサイズを指定する処理
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 横方向のスペース調整
        let horizontalSpace:CGFloat = 40
        let cellSize:CGFloat = self.view.bounds.width/2 - horizontalSpace
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
        
        
    }
    
    //曲追加(仮実装)
    func addMusic(num: Int){
        let playlist = realm.objects(Playlist.self).filter("id == %@",num + 1)[0]

        let addMusic = Music()
        let music = readMusic()
        if music != nil {
            let musics = realm.objects(Music.self).count
            addMusic.id = musics + 1
        } else {
            addMusic.id = 1
        }
        
        addMusic.spotify_id = Musiclist[0].spotify_id
        addMusic.artist = Musiclist[0].artist
        addMusic.album = Musiclist[0].album
        addMusic.name = Musiclist[0].name
        addMusic.thumbnail = Musiclist[0].thumbnail
        try! realm.write {
            playlist.musics.append(addMusic)
        }

    }
    
    
    func toPlaylistDetail(id: Int){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "PlaylistDetail")as? PlaylistDetailViewController else
        { return }
        vc.id = String(id)
        navigationController?.pushViewController(vc, animated: true)
    }

}
