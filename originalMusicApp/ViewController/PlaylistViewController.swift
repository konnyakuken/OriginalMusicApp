//
//  PlaylistViewController.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/19.
//

import UIKit
import RealmSwift

class PlaylistViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = true
        
        // UICollectionView のデータを更新した後に追加
        collectionView.reloadData()
        
        // レイアウトを調整
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout

        
        // collectionViewレイアウト設定(行間)
        //let layout = UICollectionViewFlowLayout()
        //layout.minimumLineSpacing = 30
        //collectionView.collectionViewLayout = layout
    }
    
    //Viewが表示されるたびに呼ばれる。
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let result = realm.objects(Playlist.self).count
        //セクションの中のセルの数
        return result+1
    }
    
    //セルに表示する内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //セルの生成
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistCell", for: indexPath)
        //label設定
        let label = cell.contentView.viewWithTag(1) as! UILabel
        let imageView = cell.contentView.viewWithTag(3) as! UIImageView
        
        if(indexPath.row == 0){
            label.text = "新しいプレイリストを作成"
            label.numberOfLines = 0
            let cellImage = UIImage(named: "iTunesArtwork")
            imageView.image = cellImage
        }else{
            let playlistDB = realm.objects(Playlist.self).filter("id == %@",indexPath.row)
            label.text = String(playlistDB[0].playlist_name)
            if(!playlistDB[0].musics.isEmpty){
                let playlistImage = playlistDB[0].musics[0].thumbnail
                let cellImage = getImageByUrl(url: playlistImage)
                // UIImageをUIImageViewのimageとして設定
                imageView.image = cellImage
            }
            
        }
        return cell
    }
    
    //Cellがクリックされた時によばれます
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("選択しました: \(indexPath.row)")
        if(indexPath.row == 0){
            toCreatePlaylist()
        }else{
            let playlistId = realm.objects(Playlist.self).filter("id == %@",indexPath.row)[0].id
            toPlaylistDetail(id: playlistId)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let horizontalSpace : CGFloat = 40
            let cellSize : CGFloat = self.view.bounds.width / 2 - horizontalSpace
            return CGSize(width: cellSize, height: cellSize)
        }
    
    
    
    func toCreatePlaylist(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "CreatePlaylist")as? CreatePlaylistViewController else
        { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func toPlaylistDetail(id: Int){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "PlaylistDetail")as? PlaylistDetailViewController else
        { return }
        vc.id = String(id)
        navigationController?.pushViewController(vc, animated: true)
    }
    


}
