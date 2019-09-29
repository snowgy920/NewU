//
//  ViewController.swift
//  Test
//
//  Created by Sergiy on 9/24/19.
//  Copyright © 2019 Sergiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView_background: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//   Set Background Slider
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)->CGSize{
        let cell_width = collectionView_background.frame.size.width
        let cell_height = collectionView_background.frame.size.height
        
        return CGSize(width: cell_width, height: cell_height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoginCell", for: indexPath) as! Theme_Background_Item
        
        cell.view_background.backgroundColor = UIColor().MygetColorFromHex(backgroundColor[indexPath.row])
        return cell
    }
    
//  Set Button Handler
    @IBAction func clickBlutBtn(_ sender: UIButton) {
        backgroundColor_type = 0
    }
    
    @IBAction func clickPinkBtn(_ sender: Any) {
        backgroundColor_type = 1
    }
}

