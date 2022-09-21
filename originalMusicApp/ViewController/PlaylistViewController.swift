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
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //セクションの中のセルの数
        return realm.objects(Playlist.self).count
    }
    
    //セルに表示する内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //セルの生成
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistCell", for: indexPath)
        //label設定
        let label = cell.contentView.viewWithTag(1) as! UILabel
        
        label.text = String(indexPath.row + 1)
        return cell
    }
    
    //セルのサイズを指定する処理
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 横方向のスペース調整
        let horizontalSpace:CGFloat = 5
        //セルのサイズを指定。画面上にセルを3つ表示させたいのであれば、デバイスの横幅を3分割した横幅　- セル間のスペース*2（セル間のスペースが二つあるため）
        let cellSize:CGFloat = self.view.bounds.width/3 - horizontalSpace*2

        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    

}
