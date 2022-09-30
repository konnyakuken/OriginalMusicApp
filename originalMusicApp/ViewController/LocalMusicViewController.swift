//
//  LocalMusicViewController.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/30.
//

import UIKit
import RealmSwift
import MediaPlayer

class LocalMusicViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate, MPMediaPickerControllerDelegate {


    @IBOutlet var searchTitleTextField:UITextField!
    @IBOutlet var MusicTable: UITableView!
    
    var player:MPMusicPlayerController!
    
    var accessToken = ""
    var Musiclist = [MusicDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = MPMusicPlayerController.applicationMusicPlayer
        
        MusicTable.dataSource = self
        MusicTable.delegate = self
        
        // Do any additional setup after loading the view.
        
    }
    
    //Viewが表示される直前に呼ばれる。
    //Viewが表示されるたびに呼ばれる。
    override func viewWillAppear(_ animated: Bool) {
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Musiclist.count
    }
    
    //セルに表示する内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath)
       
        cell.textLabel?.text = "\(Musiclist[indexPath.row].name)"
        cell.textLabel?.textColor = .white
        let imageUrl:UIImage = self.getImageByUrl(url: Musiclist[indexPath.row].thumbnail)
        cell.imageView?.image = imageUrl
        //cell.detailTextLabel?.text = "\(results[indexPath.row].artist)"
        cell.detailTextLabel?.text = "\(Musiclist[indexPath.row].artist)"
        
        return cell
    }
    
    //Cellがクリックされた時によばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let results = Musiclist[indexPath.row]
        //曲情報を送信
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "addPlaylistView")as? AddPlaylistViewController else
        { return }
        vc.Musiclist = [MusicDetail]()
        vc.Musiclist.append(results)
        navigationController?.pushViewController(vc, animated: true)
        print(indexPath.row)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            search()
            return true
        }
    
    
    @IBAction func search(){
        Musiclist = [MusicDetail]()
        //var title: String = searchTitleTextField.text!
        // 曲の一覧を取得
        let mPMediaQuery = MPMediaQuery.songs()
        print(mPMediaQuery)
        print(MPMediaQuery.albums())
    }
    
    @IBAction func pick(sender: AnyObject) {
         // MPMediaPickerControllerのインスタンスを作成
         let picker = MPMediaPickerController()
         // ピッカーのデリゲートを設定
         picker.delegate = self
         // 複数選択を不可にする。（trueにすると、複数選択できる）
         picker.allowsPickingMultipleItems = false
         // ピッカーを表示する
        present(picker, animated: true, completion: nil)
     }
    
    // メディアアイテムピッカーでアイテムを選択完了したときに呼び出される
       func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
           
           print(mediaItemCollection)
           // ピッカーを閉じ、破棄する
           dismiss(animated: true, completion: nil)
           
       }
       
       
       //選択がキャンセルされた場合に呼ばれる
       func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
           // ピッカーを閉じ、破棄する
           dismiss(animated: true, completion: nil)
       }
    
    @IBAction func pickMusic(_ sender: Any) {
      let picker = MPMediaPickerController()
      picker.delegate = self
      //曲の複数選択の有無
      picker.allowsPickingMultipleItems = false
      
      present(picker, animated: true, completion: nil)
     }
     
     //音楽が選択された時呼ばれるdelegate
     func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
         let items = mediaItemCollection.items
      if items.isEmpty {
       print("曲が選択されていない")
       return
      }
      
      let musicTitle = items[0].title //曲タイトル
      let musicArtist = items[0].artist //アーチスト名
      let albumTitle = items[0].albumTitle //アルバムタイトル
      let albunArtist = items[0].albumArtist //アルバムアーチスト名
     print(musicTitle)
     print(albunArtist)
         
      //player.setQueue(with: mediaItemCollection)
      //player.play() //曲の再生
      
      //pickerを消す
      dismiss(animated: true, completion: nil)
     }
}
