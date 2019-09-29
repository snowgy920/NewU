//
//  TotalPageViewController.swift
//  Test
//
//  Created by Sergiy on 9/25/19.
//  Copyright © 2019 Sergiy. All rights reserved.
//

import UIKit
import BetterSegmentedControl


class TotalPageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    var data_percent = [TotalPage_Percent_Data]()

    @IBOutlet weak var view_1: UIView!
    @IBOutlet weak var view_2: UIView!
    @IBOutlet weak var view_3: UIView!
    @IBOutlet weak var view_4: UIView!
    @IBOutlet weak var view_5: UIView!
    @IBOutlet weak var view_6: UIView!
    
    @IBOutlet weak var collection_Percent: UICollectionView!
    @IBOutlet weak var progress_Water: ProgressWView!
    @IBOutlet weak var progress_Walk: PieChartView!
    
    @IBOutlet weak var stateSwitch: BetterSegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data_percent = [
            TotalPage_Percent_Data.init(vitaminName: "Vitamin A", percent: "70"),
            TotalPage_Percent_Data.init(vitaminName: "Vitamin B1", percent: "12"),
            TotalPage_Percent_Data.init(vitaminName: "Vitamin B2", percent: "78"),
            TotalPage_Percent_Data.init(vitaminName: "Vitamin B5", percent: "78"),
            TotalPage_Percent_Data.init(vitaminName: "Vitamin B6", percent: "78"),
            TotalPage_Percent_Data.init(vitaminName: "Vitamin B12", percent: "78"),
            TotalPage_Percent_Data.init(vitaminName: "Vitamin C", percent: "78"),
            TotalPage_Percent_Data.init(vitaminName: "Vitamin D", percent: "20"),
            TotalPage_Percent_Data.init(vitaminName: "Vitamin E", percent: "78"),
            TotalPage_Percent_Data.init(vitaminName: "Vitamin K", percent: "78"),
            TotalPage_Percent_Data.init(vitaminName: "Blotin", percent: "78"),
            TotalPage_Percent_Data.init(vitaminName: "Folsaure", percent: "78"),
            TotalPage_Percent_Data.init(vitaminName: "Niacin", percent: "78")]
        
        
        view_1.MakeShadowRoundView(20)
        view_2.MakeShadowRoundView(20)
        view_3.MakeShadowRoundView(20)
        view_4.MakeShadowRoundView(20)
        view_5.MakeShadowRoundView(20)
        view_6.MakeShadowRoundView(20)
       
        stateSwitch.layer.shadowColor = UIColor.black.cgColor
//        stateSwitch.layer.shadowOffset = CGSize(width: 0.3, height: 0.1)  //Here you control x and y
        stateSwitch.layer.shadowOpacity = 0.2
        stateSwitch.layer.shadowRadius = 9.0 //Here your control your blur
        stateSwitch.layer.masksToBounds =  false
        stateSwitch.layer.shadowPath = UIBezierPath(rect: stateSwitch.bounds).cgPath
        
        stateSwitch.segments = LabelSegment.segments(withTitles: ["STATS", "STORE"],
                                                     normalFont: UIFont(name: "SFProDisplay-Light", size: 12),
                                                     selectedFont: UIFont(name: "SFProDisplay-Light", size: 12))

        
        progress_Walk.percent = 0.77
        progress_Water.percent = 0.7
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        progress_Walk.animateChart()
        progress_Water.animateProgress()
        
        for cell in collection_Percent.visibleCells as [UICollectionViewCell] {
            let v_cell = cell as! TotalPageCollectionViewCell
            v_cell.progress_percent.animateProgress()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)->CGSize{
        let cell_width = collection_Percent.frame.size.width
//        let cell_height = CGFloat(15)
        let cell_height = CGFloat(collection_Percent.frame.size.height)/CGFloat(data_percent.count)
        return CGSize(width: cell_width, height: cell_height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data_percent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PercentCell", for: indexPath) as! TotalPageCollectionViewCell
        
        cell.label_percent.text = data_percent[indexPath.row].percent + "%"
        cell.label_vitaminName.text = data_percent[indexPath.row].vitaminName
        
        cell.view_percent.layer.cornerRadius = 5
        cell.view_percent.clipsToBounds = true
        
        cell.progress_percent.percent = CGFloat((data_percent[indexPath.row].percent as NSString).floatValue) / 100
        
        return cell
    }
    
    
}
