//
//  SearchViewController.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/19.
//

import UIKit
import RealmSwift
import MediaPlayer

class SearchViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MPMediaPickerControllerDelegate{
    
    
    private let clientID = SecurityToken.ClientID
    private let clientSecret = SecurityToken.ClientSecret
    @IBOutlet var searchTitleTextField:UITextField!
    @IBOutlet var MusicTable: UITableView!
    
    var player:MPMusicPlayerController!
    var accessToken = ""
    var Musiclist = [MusicDetail]()
    var LocalMusiclist = [LocalMusicDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = MPMusicPlayerController.applicationMusicPlayer
        MusicTable.dataSource = self
        MusicTable.delegate = self
        searchTitleTextField.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    //Viewが表示される直前に呼ばれる。
    //Viewが表示されるたびに呼ばれる。
    override func viewWillAppear(_ animated: Bool) {
        getAccessToken()
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
        //print(indexPath.row)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            search()
            return true
        }
    
    
    func search(){
        Musiclist = [MusicDetail]()
        var title: String = searchTitleTextField.text!
        title = urlEncode(beforeText: title)
        let url = URL(string: "https://api.spotify.com/v1/search?q=\(title)&type=track")!  //URLを生成
        var request = URLRequest(url: url)               //Requestを生成
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(accessToken)"]
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in  //非同期で通信を行う
            guard let data = data else { return }
            do {
                let object = try JSONDecoder().decode(MusicData.self, from: data)
                for i in object.tracks.items {
                    self.Musiclist.append(MusicDetail(spotify_id: i.uri, type: "Spotify", artist: i.album.artists[0].name, album: i.album.name, thumbnail: i.album.images[0].url, name: i.name, duration: i.duration_ms))
                }
                print("成功!!")
                //print(self.Musiclist)
                DispatchQueue.main.async {
                    self.MusicTable.reloadData()
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
        
    }
    

    
    // ボタンクリック時に呼ばれる
     func getAccessToken() {
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
                let object = try JSONDecoder().decode(AccessToken.self, from: data)
                //print(object.access_token)
                self.accessToken = object.access_token
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    func urlEncode(beforeText: String) -> String {
        // RFC3986 に準拠
        // 変換対象外とする文字列（英数字と-._~）
        let allowedCharacters = NSCharacterSet.alphanumerics.union(.init(charactersIn: "-._~"))
            
        if let encodedText = beforeText.addingPercentEncoding(withAllowedCharacters: allowedCharacters) {
            return encodedText
        }
        return ""
    }
    
    @IBAction func LocalPickMusic(_ sender: Any) {
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
    let musicTitle = items[0].title!
    let musicArtist = items[0].artist!
    let albumTitle = items[0].albumTitle!
    let albunArtist = items[0].albumArtist!
    let localid = String(items[0].persistentID)
         
      //player.setQueue(with: mediaItemCollection)
      //player.play() //曲の再生
     
         
         
      //pickerを消す
    dismiss(animated: true, completion: nil)
         
    self.LocalMusiclist = [LocalMusicDetail]()
    self.LocalMusiclist.append(LocalMusicDetail(music_data: localid, type: "Local", artist: musicArtist, album: albumTitle, thumbnail: "0", name: musicTitle))
    toLocalAddMusic()
     }
    
    func toLocalAddMusic(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "LocalAddPlaylistView")as? LocalAddPlaylistViewController else
        { return }
        vc.Musiclist = [LocalMusicDetail]()
        vc.Musiclist.append(LocalMusiclist[0])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

struct MusicData: Codable {
    var tracks: Tracks
}

struct Tracks: Codable {
    var items: [Items]
}

struct Items: Codable{
    var album:Album
    var uri: String
    var duration_ms: Int
    var name: String
}

struct Album: Codable{
    var name: String
    var images: [Image]
    var artists:[Artist]
}

struct Image: Codable{
    var url:String
}

struct Artist: Codable{
    var name: String
}

struct AccessToken: Codable {
    let access_token: String
}


