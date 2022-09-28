//
//  MusicViewController.swift
//  originalMusicApp
//
//  Created by 若宮拓也 on 2022/09/28.
//

import UIKit
import RealmSwift

class MusicViewController: UIViewController {
    
    @IBOutlet var musicName:UILabel!
    @IBOutlet var musicJaket:UIImageView!
    @IBOutlet var artist:UILabel!
    @IBOutlet var playButton:UIButton!
    @IBOutlet var nextButton:UIButton!
    @IBOutlet var backButton:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
